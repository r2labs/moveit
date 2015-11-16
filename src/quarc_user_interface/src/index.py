#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cherrypy
import os, string

from jinja2 import Environment, FileSystemLoader
env = Environment(loader=FileSystemLoader(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')))

import rospy
from quarc_user_interface.msg import user_input


class CoordinatesInvalidException(Exception):
    pass


class SimpleUserInterface(object):


    def __init__(self):
        self.site_header = env.get_template('site_header.html').render()
        self.site_end = env.get_template('site_end.html').render()
        self.publisher = rospy.Publisher('user_interface', user_input, queue_size=10)
        rospy.init_node('quarc_user_interface')



    def siteify(self, body):
        return (self.site_header,body,self.site_end)


    def publish(self):
        msg = user_input()
        msg.pick_X, msg.pick_Y, msg.pick_Z = cherrypy.session['raw'][0]
        msg.place_X, msg.place_Y, msg.place_Z = cherrypy.session['raw'][1]
        msg.gripper_open = cherrypy.session['gripper_open']
        self.publisher.publish(msg)


    def parse_coordinates(self, coordinates):
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
    def index(self, pick_coordinates = None, place_coordinates = None):
        try:
            pick  = self.parse_coordinates(pick_coordinates)
            place  = self.parse_coordinates(place_coordinates)
            path = "%s -> %s" % (pick, place)
            cherrypy.session['raw'] = (pick, place)
            cherrypy.session['pick'] = pick
            cherrypy.session['place'] = place
            cherrypy.session['path_string'] = path
            cherrypy.session['gripper_open'] = True
            self.publish()
        except CoordinatesInvalidException:
            # try, try again
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = env.get_template('index.html') \
                   .render(action='index',
                           default_pick_text=place_coordinates,
                           default_place_text=pick_coordinates,
                           pick_text='Pick object from:',
                           pick_name='pick_coordinates',
                           place_text='Place object at:',
                           place_name='place_coordinates',
                           submit_button_text='Start')
        return self.siteify(index)


    @cherrypy.expose
    def debug(self, pick_coordinates = None, place_coordinates = None,
              gripper_open = True):
        try:
            pick  = self.parse_coordinates(pick_coordinates)
            place  = self.parse_coordinates(place_coordinates)
            path = "%s -> %s" % (pick, place)
            cherrypy.session['raw'] = (pick, place)
            cherrypy.session['pick'] = pick
            cherrypy.session['place'] = place
            cherrypy.session['path_string'] = path
            cherrypy.session['gripper_open'] = gripper_open
            self.publish()
        except CoordinatesInvalidException:
            # try, try again
            pick_coordinates = '(x,y,z)'
            place_coordinates = '(x,y,z)'

        index = env.get_template('debug.html') \
                   .render(action='debug',
                           default_pick_text=place_coordinates,
                           default_place_text=pick_coordinates,
                           pick_text='Pick object from:',
                           pick_name='pick_coordinates',
                           place_text='Place object at:',
                           place_name='place_coordinates',
                           submit_button_text='Start',
                           gripper_checked='checked' if not gripper_open else '',
                           gripper_box_text='Close gripper',
                           gripper_box_name='gripper_open')
        return self.siteify(index)


    # @cherrypy.expose
    # def parse_path(self, pick_coordinates, place_coordinates):
    #     pick  = self.parse_coordinates(pick_coordinates)
    #     place  = self.parse_coordinates(place_coordinates)
    #     path = "%s -> %s" % (pick, place)
    #     cherrypy.session['raw'] = (pick, place)
    #     cherrypy.session['pick'] = pick
    #     cherrypy.session['place'] = place
    #     cherrypy.session['path_string'] = path
    #     page = env.get_template('parse_path.html') \
    #               .render(action='index', path=path,
    #                       submit_button_text='Plan another path')
    #     self.publish()
    #     return self.siteify(page)

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
