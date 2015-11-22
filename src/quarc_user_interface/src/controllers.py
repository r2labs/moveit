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
                             routine['x'], routine['y'],
                             len(dropzones) - i)
            self.place_domino(robot_controller, dropzones[i])
        if not routine.get('leave_standing'):
            self.knock_dominos_over(robot_controller, dropzones[-1])

        
    def rotate_domino(self, robot_controller, x, y):
        """Rotate the domino on the ground 90 degrees."""
        robot_controller.grip()
        robot_controller.goto(x+30, y-22, 0, -90)
        robot_controller.goto(x-25, y-18, 0, -90)
        robot_controller.goto(x-33, y-17, 0, -90)
        robot_controller.goto(x-35, y-13, 0, -90)
        robot_controller.goto(x, y, 45, -90)
        return
                                         
        
    def pick_domino(self, robot_controller, x, y, stack_height):
        """Pick up the top domino from the specified stack of tiles."""
        robot_controller.pick(x, y, (stack_height-1) * 11, -90)

        
    def place_drop(self, robot_controller, x, y, z, gripper_angle_degrees):
        """Signal the arm to place an object at the specified coordinates, ."""
        vertical_buffer_height = 60
        robot_controller.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)
        robot_controller.goto(x, y, z, gripper_angle_degrees)
        robot_controller.ungrip()
        robot_controller.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)


    def place_domino(self, robot_controller, dropzone_string):
        """Dropzone_string freshly parsed from yaml file."""
        x = float(dropzone_string.split(",")[0]) + 10
        y = float(dropzone_string.split(",")[1]) - 10
        try:
            rotate = float(dropzone_string.split(",")[2])
        except IndexError:
            rotate = None
        # rotate tells us to rotate the domino once it is flat on the
        # groupd. This necessarily means we should place it flat on the ground
        if rotate:
            self.place_drop(robot_controller, x, y, 0, -90)
            self.rotate_domino(robot_controller, x, y)
        else:
            robot_controller.place(x, y, self.domino_place_height, 0)


    def knock_dominos_over(self, robot_controller, dropzone_string):
        """Knock over domino at specified dropzone."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        robot_controller.goto(x+5, y-35, 35, 0)
        robot_controller.grip()
        robot_controller.goto(x+5, y, 35, -5)
        robot_controller.goto(x+5, y-35, 35, -5)
        robot_controller.rest()
