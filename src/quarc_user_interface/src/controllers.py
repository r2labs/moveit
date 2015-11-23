#!/usr/bin/env python
# Written by Eric Crosson
# 2015-11-19

from time import sleep

class Controller():
    pass


class DominoController(Controller):


    def __init__(self, robot_controller):
        """Initialize a Domino Controller."""
        self.domino_place_height = 20
        self.robot_controller = robot_controller


    def doit(self, routine):
        """Accepts a routine (already loaded yaml file) to execute."""
        dropzones = routine.get('dropzones')
        self.robot_controller.ungrip()
        for i in range(len(dropzones)):
            if self.robot_controller.canceled():
                return
            self.pick_domino(routine['x'], routine['y'], len(dropzones) - i)
            self.place_domino(dropzones[i])
        self.knockdown_decision_tree(routine)


    def knockdown_decision_tree(self, routine):
        """Consider the yaml file options and move the arm in the appropriate
        knockdown dance.

        """
        for movement in routine.get('knockdown_routine', []):
            self.move_arm(movement)
        else:
            if routine.get('leave_standing'):
                self.robot_controller.rest()
            else:
                self.knock_dominos_over(routine.get('dropzones',[])[-1])
            

    def rotate_domino(self, x, y):
        """Rotate the domino on the ground 90 degrees."""
        self.robot_controller.grip()
        for xo,yo in [(30,-38),(25,-34),(-33,-33),(-37,-25)]:
            self.robot_controller(x-xo, y-yo, 0, -90)
        self.robot_controller.goto(x, y, 45, -90)
                                         
        
    def pick_domino(self, x, y, stack_height):
        """Pick up the top domino from the specified stack of tiles."""
        self.robot_controller.pick(x, y, (stack_height-1) * 11, -90)

        
    def place_drop(self, x, y, z, gripper_angle_degrees):
        """Signal the arm to place an object at the specified coordinates, ."""
        vertical_buffer_height = 60
        self.robot_controller.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)
        self.robot_controller.goto(x, y, z, gripper_angle_degrees)
        self.robot_controller.ungrip()
        self.robot_controller.goto(x, y, z + vertical_buffer_height, gripper_angle_degrees)


    def parse_yaml_line(self, string):
        try:
            x = float(string.split(",")[0]) + 10
            y = float(string.split(",")[1]) - 10
            try:
                z = float(string.split(",")[2])
            except IndexError:
                z = self.domino_place_height
            try:
                gripper_angle_degrees = float(string.split(",")[3])
            except IndexError:
                gripper_angle_degrees = -1
            # rotate tells us to rotate the domino once it is flat on the
            # ground. This necessarily means we should place it flat on the ground
            try:
                rotate = float(string.split(",")[4])
            except IndexError:
                rotate = False
        except ValueError:
            if string == 'rest':
                x = robot_controller.rest_x
                y = robot_controller.rest_y
                z = robot_controller.rest_z
                gripper_angle_degrees = robot_controller.rest_gripper_angle_degrees
        return (x, y, z, gripper_angle_degrees, rotate) 


    def place_domino(self, dropzone_string):
        """Dropzone_string freshly parsed from yaml file."""
        x, y, z, gripper_angle_degrees, rotate = self.parse_yaml_line(dropzone_string)
        self.robot_controller.place(x, y, z, gripper_angle_degrees)
        if rotate:
            self.rotate_domino(x, y)


    def move_arm(self, movezone_string):
        x, y, z, gripper_angle_degrees, rotate = self.parse_yaml_line(movezone_string)
        self.robot_controller.goto(x, y, z, gripper_angle_degrees)
        

    def knock_dominos_over(self, dropzone_string):
        """Knock over domino at specified dropzone."""
        x = float(dropzone_string.split(",")[0])
        y = float(dropzone_string.split(",")[1])
        self.robot_controller.goto(x+5, y-35, 15, -90)
        self.robot_controller.grip()
        self.robot_controller.goto(x+5, y, 20, -90)
        self.robot_controller.goto(x+5, y-30, 15, -90)
        self.robot_controller.rest()
