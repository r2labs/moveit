#include <string>
#include <ros/ros.h>
#include "chatter.hpp"

class chatter_driver {
public:
    std::string whoami;
    ros::NodeHandle nh;
    chatter fgt;

    chatter_driver(ros::NodeHandle &nh) {
        whoami = "I'm a chatter, bitch!";
        this->nh = nh;
        fgt = chatter();
    }

    void spin();
};
