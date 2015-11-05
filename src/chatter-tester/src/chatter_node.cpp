#include <ros/ros.h>
#include "chatter_driver.hpp"

int main( int argc, char** argv )
{
    ros::init( argc, argv, "chatter_node" );
    ros::NodeHandle nh;

    chatter_driver chat_driver(nh);

    chat_driver.spin();

    return 0;
}
