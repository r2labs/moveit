#!/usr/bin/env python
# Written by Eric Crosson
# 2015-11-01

import rospy
import moveit_commander
import sys

from std_msgs.msg import String
# from lynxmotion_quarc.src.reporter import reporter, sleeper

def move_group_python_interface():
    print "============ Starting move_group_python_interface setup"
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node('move_group_python_interface', anonymous=True)

    ## Instantiate a RobotCommander object.  This object is an interface to
    ## the robot as a whole.
    robot = moveit_commander.RobotCommander()
    
    ## Instantiate a PlanningSceneInterface object.  This object is an interface
    ## to the world surrounding the robot.
    moveit_commander.PlanningSceneInterface()
    
    ## Instantiate a MoveGroupCommander object.  This object is an interface
    ## to one group of joints.  In this case the group is the joints in the left
    ## arm.  This interface can be used to plan and execute motions on the left
    ## arm.
    rospy.sleep(1)
    group = moveit_commander.MoveGroupCommander("arm")
    
    ## Getting Basic Information
    ## ^^^^^^^^^^^^^^^^^^^^^^^^^
    ##
    ## We can get the name of the reference frame for this robot
    # print "============ Reference frame: %s" % group.get_planning_frame()
    
    # ## We can also print the name of the end-effector link for this group
    # print "============ Reference frame: %s" % group.get_end_effector_link()
    
    ## We can get a list of all the groups in the robot
    print "============ Robot Groups:"
    print robot.get_group_names()
    
    ## Sometimes for debugging it is useful to print the entire state of the
    ## robot.
    print "============ Printing robot state"
    print robot.get_current_state()
    print "============"
    rospy.spin()
    moveit_commander.roscpp_shutdown()


if __name__=='__main__':
    try:
        move_group_python_interface()
    except rospy.ROSInterruptException:
        pass
