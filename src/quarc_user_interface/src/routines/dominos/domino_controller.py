#!/usr/bin/env python
# Written by Eric Crosson
# 2015-11-19

import time
from quarc_user_interface.src.routines import routine


class DominoController(Routine):


    def __init__(self):
        self.domino_place_height = 30


    def exec(self, routine, robot_controller):
        """Accepts a routine (already loaded yaml file) to execute."""
        dropzones = routine.get('dropzones')
        for i in range(length(dropzones)):
            for droppoint in dropzones:
                self.pick_domino(robot_controller,
                                 routine['given']['x'],
                                 routine['given']['y'],
                                 length(dropzones) - i)
                self.place_domino(robot_controller, dropzone)
        self.knock_dominos_over(robot_controller, dropzones[-1])


    def pick_domino(self, x, y, stack_height):
        """Pick up the top domino from the specified stack of tiles."""
        robot_controller.pick(x, y, stack_height * 10, -90)


    def place_domino(self, robot_controller, dropzone_string):
        """Dropzone_string freshly parsed from yaml file."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        robot_controller.place(x, y, self.domino_place_height, -10)


    def knock_dominos_over(self, robot_controller, dropzone):
        """Knock over domino at specified dropzone."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        robot_controller.grip()
        robot_controller.goto(x, y-5, self.domino_place_height)
        sleep(1)
        robot_controller.goto(x, y+2, self.domino_place_height)
        sleep(1)
        robot_controller.goto(x, y-5, self.domino_place_height)
        sleep(1)
        robot_controller.rest()
