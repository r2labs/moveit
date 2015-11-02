#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cherrypy
import os, string

from jinja2 import Environment, FileSystemLoader
env = Environment(loader=FileSystemLoader('templates'))

class SimpleUserInterface(object):

    def __init__(self):
        self.site_header = env.get_template('site_header.html').render()
        self.site_end = env.get_template('site_end.html').render()

    def siteify(self, body):
        return (self.site_header,body,self.site_end)

    def parse_coordinates(self, coordinates):
        coords = []
        for i in coordinates.strip("()").split(","):
            try:
                coords.append(float(i))
            except ValueError:
                coords.append(-1)
        return tuple(coords)

    @cherrypy.expose
    def index(self):
        index = env.get_template('index.html') \
                   .render(action='parse_path', default_text='(x,y,z)',
                           pick_text='Pick object from:', pick_name='pick_coordinates',
                           place_text='Place object at:', place_name='place_coordinates',
                           submit_button_text='Start')
        return self.siteify(index)

    @cherrypy.expose
    def parse_path(self, pick_coordinates, place_coordinates):
        pick  = self.parse_coordinates(pick_coordinates)
        place  = self.parse_coordinates(place_coordinates)
        path = "%s -> %s" % (pick, place)
        cherrypy.session['pick'] = pick
        cherrypy.session['place'] = place
        cherrypy.session['path_string'] = path
        page = env.get_template('parse_path.html') \
                  .render(action='index', path=path, 
                          submit_button_text='Plan another path')
        return self.siteify(page)

if __name__ == '__main__':
    conf = {
        '/': {
            'tools.sessions.on': True,
            'tools.staticdir.root': os.path.abspath(os.getcwd())
        },
        '/static': {
            'tools.staticdir.on': True,
            'tools.staticdir.dir': './public'
        },
	'/images':{
	     'tools.staticdir.on': True,
	     'tools.staticdir.dir': '../imgs'
	},
	'/favicon.ico':{
	     'tools.staticfile.on': True,
	     'tools.staticfile.filename': '/images/favicon.ico'
	}
    }

    cherrypy.config.update({'server.socket_host': '127.0.0.1'})
    cherrypy.config.update({'server.socket_port': 8080})
    cherrypy.quickstart(SimpleUserInterface(), '/', conf)
