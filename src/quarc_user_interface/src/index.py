#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cherrypy
import os, string, sys

from jinja2 import Environment, FileSystemLoader
env = Environment(loader=FileSystemLoader(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')))

import rospy
from quarc_user_interface.msg import user_input
from quarc_user_interface.msg import set_position
from quarc_user_interface.msg import set_gripper
from quarc_vision.msg import vision_object

import controllers

import os
import yaml
import logging
from time import sleep
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
    def __init__(self, x, y, radius, color):
        self.x = x;
        self.y = y;
        self.radius = radius;
        self.color = color;
    def json(self):
        return str(self.__dict__)

class SimpleUserInterface(object):

    def __init__(self):
        """Initialize ros publishers and node."""
        self.CANCELED = False
        self.site_header = env.get_template('site_header.html').render()
        self.site_end = env.get_template('site_end.html').render()
        self.pp_publisher = rospy.Publisher('user_interface', user_input, queue_size=10)
        self.goto_publisher = rospy.Publisher('set_position', set_position, queue_size=10)
        self.grip_publisher = rospy.Publisher('set_gripper', set_gripper, queue_size=10)
        rospy.init_node('quarc_user_interface')
        # rospy.init_node('quarc_vision', anonymous=True)
        self.vision_subscriber = rospy.Subscriber("vision_object", vision_object, self.vision_callback)
        self.rest()
        self.vision_objects = []

    def vision_callback(self, msg):
        self.vision_objects = []
        objs = zip(msg.x, msg.y, msg.radius, msg.color)
        for obj in objs:
            self.vision_objects.append(VisionObject(obj[0], obj[1], obj[2], obj[3]))

    def siteify(self, body):
        """Return site's body, wrapped in header and footer."""
        retur
        n (self.site_header,body,self.site_end)


    def get_routine(self, routine_type, routine_name):
        """Load the plans for a routine of specified type and name."""
        with open(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                   routine_type,
                                   '%s.yml' % routine_name)) as handle:
            return yaml.safe_load(handle)


    @cherrypy.expose
    def exec_routine(self, routine_type, routine_name):
        # TODO: complete use of design patterns, finish the meta code
        if routine_type == 'dominos':
            routine = self.get_routine(routine_type, routine_name)
            controller = controllers.DominoController()
            controller.doit(routine, self)

    @cherrypy.expose
    def vision(self):
        ret = ""
        for v in self.vision_objects:
            ret += v.json()
        return ret

    @cherrypy.expose
    def cancel(self):
        self.CANCELED = True
        sleep(3)
        self.CANCELED = False
        self.ungrip()
        self.rest()

    def pp_publish(self):
        pass


    # def pp_publish(self):
    #     """Publish the pick and place action entered into index.html"""
    #     # pick_X, pick_Y, pick_Z = cherrypy.session['raw'][0]
    #     # place_X, place_Y, place_Z = cherrypy.session['raw'][1]
    #     self.pick(*cherrypy.session['raw'][0], -90)
    #     self.place(*cherrypy.session['raw'][0], -90)
    #     # msg.gripper_open = cherrypy.session['gripper_open'] == 'on'
    #     # self.pp_publisher.publish(msg)


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
    def grip(self, gripper_percent = 1.0, no_sleep=False):
        """Signal ros to set the gripper percent."""
        msg = set_gripper()
        msg.gripper_percent = float(gripper_percent)
        self.grip_publisher.publish(msg)
        if not no_sleep:
            sleep(1)


    @cherrypy.expose
    def ungrip(self, no_sleep=False):
        """Signal ros to open the gripper."""
        self.grip(0.0, no_sleep)


    @cherrypy.expose
    def goto(self, x, y, z, gripper_angle_degrees = -90, no_sleep=False):
        """Signal ros to move the arm to """
        if self.CANCELED:
            self.CANCELED = False
            raise CancelActionException()
        msg = set_position()
        try:
            msg.x = float(x)
            msg.y = float(y)
            msg.z = float(z)
            msg.ga_d = float(gripper_angle_degrees)
        except:
            msg.x = x
            msg.y = y
            msg.z = z
            msg.ga_d = gripper_angle_degrees
        self.goto_publisher.publish(msg)
        if not no_sleep:
            sleep(1)


    @cherrypy.expose
    def rest(self):
        """Return the robot to rest position."""
        self.ungrip()
        self.goto(-140, 0, 120, 0)


    @cherrypy.expose
    def pick(self, x, y, z, gripper_angle_degrees = -90):
        """Signal the arm to pick up an object at the specified coordinates."""
        vertical_buffer_height = 60
        x = float(x)
        y = float(y)
        z = float(z)
        self.ungrip(no_sleep=True)
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)
        self.goto(x, y, z, gripper_angle_degrees)
        self.grip()
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)

    @cherrypy.expose
    def dinodrop(self):
        """Signal the arm to place an object in a specific location."""
        self.goto(-140, 0, 150, -90)
        sleep(0.5)
        self.ungrip()

    @cherrypy.expose
    def place(self, x, y, z=5.0, gripper_angle_degrees = -90.0):
        """Signal the arm to place an object at the specified coordinates."""
        vertical_buffer_height = 60.0
        x = float(x)
        y = float(y)
        z = float(z)
        self.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)
        self.goto(x, y, z, gripper_angle_degrees)
        self.ungrip(no_sleep=True)
        sleep(0.5)
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
            # TODO: re-organize pp_publish
            self.pp_publish()
        except CoordinatesInvalidException:
            # try, try again
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = env.get_template('index.html') \
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
            # TODO: re-organize pp_publish
            self.pp_publish()
        except CoordinatesInvalidException:
            # try, try again
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = env.get_template('debug.html') \
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


if __name__ == '__main__':
    conf = {
        '/': {
            'tools.sessions.on': True,
            'tools.staticdir.root': os.path.dirname(os.path.abspath(__file__))
        },
        # '/static': {
        #     'tools.staticdir.on': True,
        #     'tools.staticdir.dir': './public'
        # },
        '/images':{
             'tools.staticdir.on': True,
             'tools.staticdir.dir': '../imgs'
        },
        # '/favicon.ico':{
        #      'tools.staticfile.on': True,
        #      'tools.staticfile.filename': '/images/favicon.ico'
        # }
    }

    cherrypy.config.update({'server.socket_host': '127.0.0.1'})
    cherrypy.config.update({'server.socket_port': 8080})
    cherrypy.quickstart(SimpleUserInterface(), '/', conf)
