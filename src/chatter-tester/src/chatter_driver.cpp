#include "chatter_driver.hpp"
#include "std_msgs/String.h"
#include "srv/user_input.h"
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

    float bas_us, shl_us, elb_us, wri_us, x, y, z, ga;
    while (ros::ok) {

        get_coords(x, y, z, ga);
        set_arm(x, y, z, ga, bas_us, shl_us, elb_us, wri_us);
        
        traj.points[0].positions[0] = bas_us;
        traj.points[0].positions[1] = shl_us;
        traj.points[0].positions[2] = elb_us;
        traj.points[0].positions[3] = wri_us;

        chatter_pub.publish(traj);
        ros::spinOnce();
        loop_rate.sleep();
    }
}

/* TODO: get coordinates from python website */
void chatter_driver::get_coords(const srv::user_input::ConstPtr& msg) {
    x = msg->pick_X;
    y = msg->pick_Y;
    z = msg->pick_Z;
    ga = 0.0;
    
    /*TODO: FIGURE OUT WHERE TO STORE PLACE YOURSELF :)*/
}

int chatter_driver::set_arm(float x, float y, float z, float grip_angle_degrees,
                             float& bas_us, float& shl_us, float& elb_us,
                             float& wri_us) {

    float grip_angle_r = radians(grip_angle_degrees);
    float base_angle_r = atan2(y, -x);
    float r = sqrt(pow(x,2) + pow(y,2));
    float z_prime = z - BASE_HGT - (sin(grip_angle_r)*GRIPPER);
    float r_prime = r - (cos(grip_angle_r)*GRIPPER);
    float q = sqrt(pow(r_prime,2) + pow(z_prime,2));
    if(y>=0)
    {
        float shoulder_angle_r = atan2(z_prime, r_prime) + acos((pow(HUMERUS,2)+pow(q,2)-pow(ULNA,2))/(2*HUMERUS*q));
    }
    else
    {
        float shoulder_angle_r = atan2(z_prime, -r_prime) + acos((pow(HUMERUS,2)+pow(q,2)-pow(ULNA,2))/(2*HUMERUS*q));
    }
    if (isnan(shoulder_angle_r) || isinf(shoulder_angle_r))
    {
        return IK_ERROR;
    }

    
    float elbow_angle_r = acos((pow(HUMERUS,2)+pow(ULNA,2)-pow(q,2))/(2*HUMERUS*ULNA));
    float wrist_angle_r = (3*M_PI/2) - elbow_angle_r - shoulder_angle_r + grip_angle_r;
    
    shl_angle_d = degrees(shoulder_angle_r);
    elb_angle_d = degrees(elbow_angle_r);
    wri_angle_d = degrees(wrist_angle_r);


    // Calculate servo angles
    // Calc relative to servo midpoint to allow compensation for servo alignment
    float bas_pos = BAS_MID + degrees(bas_angle_r);
    float shl_pos = SHL_MID + (shl_angle_d - 90.0);
    float elb_pos = ELB_MID - (elb_angle_d - 90.0);
    float wri_pos = WRI_MID + wri_angle_d;

    // If any servo ranges are exceeded, return an error
    if (bas_pos < BAS_MIN || bas_pos > BAS_MAX || shl_pos < SHL_MIN || shl_pos > SHL_MAX || elb_pos < ELB_MIN || elb_pos > ELB_MAX || wri_pos < WRI_MIN || wri_pos > WRI_MAX)
        return IK_ERROR;

    //TODO: This block should call a function that sends microseconds to TM4C
    // bas_us = lerp(bas_pos, 0, 180, SERVO_MIN_US, SERVO_MAX_US);
    // shl_us = lerp(shl_pos, 0, 180, SERVO_MIN_US, SERVO_MAX_US);
    // elb_us = lerp(elb_pos, 0, 180, SERVO_MIN_US, SERVO_MAX_US);
    // wri_us = lerp(wri_pos, 0, 180, SERVO_MIN_US, SERVO_MAX_US);
    bas_us = radians(bas_pos);
    shl_us = radians(shl_pos);
    elb_us = radians(elb_pos);
    wri_us = radians(wri_pos);
    
    
    
    //TODO: ADD GRIP CLOSE/OPEN
}

float chatter_driver::lerp(float x, float x_min, float x_max, float y_min, float y_max) {
    if (x > x_max) { return y_max; }
    else if (x < x_min) { return y_min; }
    /* TODO: send information to the IFC */
    return y_min + (y_min - y_max)*((x - x_min)/(x_max - x_min));
}

void chatter_driver::grip_close()
{
    //TODO: add command to close grip
}

void chatter_driver::grip_open()
{
    //TODO: add command to open grip
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
