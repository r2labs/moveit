#!/usr/bin/env python
# Written by Eric Crosson
# 2015-11-19

from time import sleep

class Controller():
    pass


class DominoController(Controller):


    def __init__(self):
        self.domino_place_height = 30


    def doit(self, routine, robot_controller):
        """Accepts a routine (already loaded yaml file) to execute."""
        dropzones = routine.get('dropzones')
        robot_controller.ungrip()
        for i in range(len(dropzones)):
            if robot_controller.CANCELED:
                return
            self.pick_domino(robot_controller,
                             routine['given']['x'],
                             routine['given']['y'],
                             len(dropzones) - i)
            self.place_domino(robot_controller, dropzones[i])
        self.knock_dominos_over(robot_controller, dropzones[-1])


    def pick_domino(self, robot_controller, x, y, stack_height):
        """Pick up the top domino from the specified stack of tiles."""
        robot_controller.pick(x, y, (stack_height-1) * 11, -90)


    def place_domino(self, robot_controller, dropzone_string):
        """Dropzone_string freshly parsed from yaml file."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        robot_controller.place(x, y, self.domino_place_height, 0)


    def knock_dominos_over(self, robot_controller, dropzone_string):
        """Knock over domino at specified dropzone."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        robot_controller.goto(x, y-40, self.domino_place_height, 0)
        sleep(1)
        robot_controller.grip()
        robot_controller.goto(x, y-15, self.domino_place_height, 0)
        sleep(1)
        robot_controller.goto(x, y+20, self.domino_place_height, 0)
        sleep(1)
        robot_controller.goto(x, y-15, self.domino_place_height, 0)
        sleep(1)
        robot_controller.rest()
