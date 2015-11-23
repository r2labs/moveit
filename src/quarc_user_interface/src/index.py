#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cherrypy
import os, string, sys, yaml
from jinja2 import Environment, FileSystemLoader

import rospy
from quarc_user_interface.msg import user_input
from quarc_user_interface.msg import set_position
from quarc_user_interface.msg import set_gripper
from quarc_vision.msg import vision_object

import controllers
import time

import logging
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename='/tmp/quarc_user_interface.log',
                    filemode='w')


class CoordinatesInvalidException(Exception):
    pass


class CancelActionException(Exception):
    pass


class VisionObject:

    def __init__(self, points, radius, color, cx, cy):
        self.points = points
        self.color = color
        self.radius = radius
        self.cx = cx
        self.cy = cy


    def json(self):
        return str(self.__dict__).replace("'", '"')


class SimpleUserInterface(object):

    def __init__(self):
        """Initialize ros publishers and node."""
        self.CANCELED = False
        self.env = Environment(
            loader=FileSystemLoader(
                os.path.join(os.path.dirname(os.path.abspath(__file__)),
                             'templates')))
        self.site_header = self.env.get_template('site_header.html').render()
        self.site_end = self.env.get_template('site_end.html').render()
        self.pp_publisher = rospy.Publisher('user_interface', user_input, queue_size=10)
        self.goto_publisher = rospy.Publisher('set_position', set_position, queue_size=10)
        self.grip_publisher = rospy.Publisher('set_gripper', set_gripper, queue_size=10)
        rospy.init_node('quarc_user_interface')
        self.vision_subscriber = rospy.Subscriber("vision_object", vision_object, self.vision_callback)
        self.vision_objects = []
        self.movement_time = 1.0
        self.rest_x = 140
        self.rest_y = 0
        self.rest_z = 150
        self.rest_gripper_angle_degrees = -90
        self.rest()


    def vision_callback(self, msg):
        self.vision_objects = []
        pidx = 0
        for i in range(len(msg.cx)):
            points = []
            for j in range(msg.numpoints[i]):
                points.append([msg.x[pidx], msg.y[pidx]])
                pidx += 1
                self.vision_objects.append(
                    VisionObject(points, msg.radius[i],
                                 msg.color[i], msg.cx[i], msg.cy[i]))


    @cherrypy.expose
    def vision(self):
        return '{"items": [%s]}' % \
            ','.join([str(v.__dict__).replace("'", '"') for v in self.vision_objects])


    def siteify(self, body):
        """Return site's body, wrapped in header and footer."""
        return (self.site_header,body,self.site_end)


    def get_routine(self, routine_type, routine_name):
        """Load the plans for a routine of specified type and name."""
        with open(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                   routine_type,
                                   '%s.yml' % routine_name)) as handle:
            return yaml.safe_load(handle)


    @cherrypy.expose
    def exec_routine(self, routine_type, routine_name):
        try:
            routine = self.get_routine(routine_type, routine_name)
        except:
            logging.exception('Unknown routine type or name')
        controllers.DominoController(self).doit(routine)

    @cherrypy.expose
    def cancel(self):
        self.CANCELED = True
        time.sleep(3)
        self.CANCELED = False


    def canceled(self):
        return self.CANCELED


    @cherrypy.expose
    def sort(self):
        """Sort objects on the table into bins of identifying color."""
        self.red_bucket = (110, 0)
        self.green_bucket = (185, 0)
        self.blue_bucket = (260, 0)
        while len(self.vision_objects) > 0:
            obj = sorted(self.vision_objects, key=lambda x: x.cx)[0]
            x, y = getattr(self, '%s_bucket' % obj.color)
            self.pick(200-obj.cx, obj.cy + 50, 0, -90, vertical_buffer_height=115)
            self.place(x, y, 140, -90)
        self.rest()


    # @cherrypy.expose
    # def clear_color(self, destination, *colors):
    #     """Remove all objects of specified color."""
    #     x, y = destination
    #     for color in colors:
    #         while len(self.vision_objects) > 0:
    #             obj = filter(lambda obj: obj.color == color, self.vision_objects).sort(key=lambda x: x.cx)[0]
    #             self.pick(200 - obj.cx, obj.cy + 60, 0, -90, vertical_buffer_height=30)
    #             self.place(x, y, 140, -90)
    #     self.rest()


    def pp_publish(self):
        """Publish the pick and place action entered into index.html"""
        pick_X, pick_Y, pick_Z = cherrypy.session['raw'][0]
        place_X, place_Y, place_Z = cherrypy.session['raw'][1]
        self.pick(pick_X, pick_Y, pick_Z, -90)
        self.place(place_X, place_Y, place_Z, -90)
        msg.gripper_open = cherrypy.session['gripper_open'] == 'on'
        self.pp_publisher.publish(msg)


    def parse_coordinates(self, coordinates):
        """Parse coordinates from the html text box."""
        try:
            coords = []
            for i in coordinates.strip("()").split(","):
                try:
                    coords.append(float(i))
                except ValueError:
                    coords.append(-1)
        except AttributeError:
            raise CoordinatesInvalidException()
        return tuple(coords)


    @cherrypy.expose
    def grip(self, gripper_percent = 1.0, no_sleep=False, sleep=None):
        """Signal ros to set the gripper percent."""
        msg = set_gripper()
        msg.gripper_percent = float(gripper_percent)
        self.grip_publisher.publish(msg)
        self.sleep_sequence(no_sleep, sleep)


    @cherrypy.expose
    def goto(self, x, y, z, gripper_angle_degrees=-90, no_sleep=False, sleep=None):
        """Signal ros to move the arm to """
        if self.CANCELED:
            self.CANCELED = False
            raise CancelActionException()
        msg = set_position()
        msg.x = float(x)
        msg.y = float(y)
        msg.z = float(z)
        msg.ga_d = float(gripper_angle_degrees)
        self.goto_publisher.publish(msg)
        self.sleep_sequence(no_sleep, sleep)


    def sleep_sequence(self, no_sleep, sleep_ratio):
        if no_sleep:
            return
        if sleep_ratio is None:
            sleep_ratio = 1.0
        time.sleep(self.movement_time * sleep_ratio)


    @cherrypy.expose
    def ungrip(self, no_sleep=False, sleep=None):
        """Signal ros to open the gripper."""
        self.grip(0.0, no_sleep, sleep)


    @cherrypy.expose
    def pick(self, x, y, z, gripper_angle_degrees, vertical_buffer_height=60):
        """Signal the arm to pick up an object at the specified coordinates."""
        self.ungrip(sleep=0)
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees, sleep=1.2)
        self.goto(x, y, z, gripper_angle_degrees)
        self.grip(sleep=0.5)
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)


    @cherrypy.expose
    def rest(self):
        """Return the robot to rest position."""
        self.goto(self.rest_x, self.rest_y, self.rest_z,
                  self.rest_gripper_angle_degrees, sleep=0)
        self.ungrip(sleep=0)


    @cherrypy.expose
    def place(self, x, y, z, gripper_angle_degrees, vertical_buffer_height=60):
        """Signal the arm to place an object at the specified coordinates."""
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)
        self.goto(x, y, z, gripper_angle_degrees, sleep=0.5)
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)


    @cherrypy.expose
    def index(self, pick_coordinates = None, place_coordinates = None):
        """Query the user for coordinates to do the simplest pick/place routine."""
        try:
            pick  = self.parse_coordinates(pick_coordinates)
            place  = self.parse_coordinates(place_coordinates)
            path = "%s -> %s" % (pick, place)
            cherrypy.session['raw'] = (pick, place)
            cherrypy.session['pick'] = pick
            cherrypy.session['place'] = place
            cherrypy.session['path_string'] = path
            cherrypy.session['gripper_open'] = True
            self.pp_publish()
        except CoordinatesInvalidException:
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = self.env.get_template('index.html') \
                   .render(action='index',
                           default_pick_text=pick_coordinates,
                           default_place_text=place_coordinates,
                           pick_text='Pick object from:',
                           pick_name='pick_coordinates',
                           place_text='Place object at:',
                           place_name='place_coordinates',
                           submit_button_text='Start')
        return self.siteify(index)


    @cherrypy.expose
    def debug(self, pick_coordinates = None, place_coordinates = None,
              gripper_open = 'off', mirror_coordinates='on'):
        try:
            pick  = self.parse_coordinates(pick_coordinates)
            place  = self.parse_coordinates(place_coordinates)
            if mirror_coordinates == 'on':
                place = pick
                place_coordinates = pick_coordinates
            path = "%s -> %s" % (pick, place)
            cherrypy.session['raw'] = (pick, place)
            cherrypy.session['pick'] = pick
            cherrypy.session['place'] = place
            cherrypy.session['path_string'] = path
            cherrypy.session['gripper_open'] = gripper_open
            self.pp_publish()
        except CoordinatesInvalidException:
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = self.env.get_template('debug.html') \
                   .render(action='debug',
                           default_pick_text=pick_coordinates,
                           default_place_text=place_coordinates,
                           pick_text='Pick object from:',
                           pick_name='pick_coordinates',
                           place_text='Place object at:',
                           place_name='place_coordinates',
                           submit_button_text='Start',
                           gripper_checked='checked' if gripper_open == 'on' else '',
                           gripper_box_text='Close gripper',
                           gripper_box_name='gripper_open',
                           mirror_checked='checked' if mirror_coordinates == 'on' else '',
                           mirror_box_text='Mirror coordinates',
                           mirror_box_name='mirror_coordinates')
        return self.siteify(index)


def CORS():
    cherrypy.response.headers["Access-Control-Allow-Origin"] = "*"


if __name__ == '__main__':
    conf = {
        '/': {
            'tools.sessions.on': True,
            'tools.staticdir.root': os.path.dirname(os.path.abspath(__file__)),
            'tools.CORS.on': True
        },
        '/images':{
             'tools.staticdir.on': True,
             'tools.staticdir.dir': '../imgs'
        },
    }
    cherrypy.tools.CORS = cherrypy.Tool('before_handler', CORS)
    cherrypy.config.update({'server.socket_host': '127.0.0.1'})
    cherrypy.config.update({'server.socket_port': 8080})
    cherrypy.quickstart(SimpleUserInterface(), '/', conf)
