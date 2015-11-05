#include "chatter_driver.hpp"
#include "std_msgs/String.h"
#include "math.h"
#include <sstream>
#include <trajectory_msgs/JointTrajectory.h>

/* void chatter_driver::setup() { */
/*     servo_park(); */
/* } */

void chatter_driver::spin() {
    ROS_INFO("HERSHAL: chatter spinning...");


    ros::Publisher chatter_pub =
        nh.advertise<trajectory_msgs::JointTrajectory>("tm4c/command", 1000);

    // ros::Publisher chatter_pub =
    //     nh.advertise<std_msgs::String>("tm4c/command", 1000);

    ros::Rate loop_rate(10);

    trajectory_msgs::JointTrajectory traj;
    traj.joint_names.push_back("al5d_joint_0");
    traj.joint_names.push_back("al5d_joint_1");
    traj.joint_names.push_back("al5d_joint_2");
    traj.joint_names.push_back("al5d_joint_3");
    traj.joint_names.push_back("al5d_gripper");

    trajectory_msgs::JointTrajectoryPoint p;
    p.time_from_start = ros::Duration(0);
    for (int i=0; i<5; ++i) {
        p.positions.push_back(-0.1);
        p.velocities.push_back(0.0);
        p.accelerations.push_back(0.0);
        p.effort.push_back(0.0);
    }
    traj.points.push_back(p);
    traj.header.stamp = ros::Time::now();

    unsigned int cnt = 0;
    while (ros::ok) {
        std::stringstream ss;
        ss << fgt.chat() << " " << cnt;
        
        // std_msgs::String ros_msg;
        // ros_msg.data = ss.str();
        // chatter_pub.publish(ros_msg);
        // ROS_INFO("HERSHAL: chatter_driver chatting...");

        chatter_pub.publish(traj);

        ros::spinOnce();
        loop_rate.sleep();
        ++cnt;
    }
}

// void chatter_driver::parse_joints() {

//     ros::NodeHandle priv_nh( "~" );
    
//     // Parse joints ros param
//     XmlRpc::XmlRpcValue joints_list;
//     if(priv_nh.getParam("joints", joints_list)) {
//         ROS_ASSERT(joints_list.getType() == XmlRpc::XmlRpcValue::TypeStruct);

//         XmlRpcValueAccess joints_struct_access(joints_list);
//         XmlRpc::XmlRpcValue::ValueStruct joints_struct = joints_struct_access.getValueStruct();

//         XmlRpc::XmlRpcValue::ValueStruct::iterator joints_it;

//         for(joints_it = joints_struct.begin(); joints_it != joints_struct.end(); joints_it++) {
//             Joint *joint = new Joint;
//             joint->name = static_cast<std::string>(joints_it->first);

//             std::string joint_graph_name = "joints/" + joint->name + "/";

//             priv_nh.param<int>(joint_graph_name + "channel", joint->properties.channel, 0);

//             // Channel must be between 0 and 31, inclusive
//             ROS_ASSERT(joint->properties.channel >= 0);
//             ROS_ASSERT(joint->properties.channel <= 31);

//             priv_nh.param<double>(joint_graph_name + "max_angle", joint->properties.max_angle, M_PI_2);
//             priv_nh.param<double>(joint_graph_name + "min_angle", joint->properties.min_angle, -M_PI_2);
//             priv_nh.param<double>(joint_graph_name + "offset_angle", joint->properties.offset_angle, 0);
//             priv_nh.param<double>(joint_graph_name + "default_angle", joint->properties.default_angle, joint->properties.offset_angle);
//             priv_nh.param<bool>(joint_graph_name + "initialize", joint->properties.initialize, true);
//             priv_nh.param<bool>(joint_graph_name + "invert", joint->properties.invert, false);

//             // Make sure no two joints have the same channel
//             ROS_ASSERT(channels[joint->properties.channel] == NULL);

//             // Make sure no two joints have the same name
//             ROS_ASSERT(joints_map.find(joint->name) == joints_map.end());

//             channels[joint->properties.channel] = joint;
//             joints_map[joint->name] = joint;
//         }
//     } else {
//         ROS_FATAL("No joints were given");
//         ROS_BREAK();
//     }
// }
