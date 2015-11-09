#include "math.h"
#include <string>
#include <ros/ros.h>
#include "chatter.hpp"

class chatter_driver {
public:
    std::string whoami;
    ros::NodeHandle nh;
    chatter chat;

    chatter_driver(ros::NodeHandle &nh) {
        whoami = "I'm chatter!";
        this->nh = nh;
        this->sub = nh.subscribe("user_interface", 10, get_coords);
        chat = chatter();
        
    }

    void spin();
    void get_coords(float& x, float& y, float& z, float& ga);
    int set_arm(float x, float y, float z, float ga,
                float& bas_us, float& shl_us, float& elb_us,
                float& wri_us);
    float lerp(float x, float x_min, float x_max, float y_min, float y_max);
    
    void grip_close();
    void grip_open();

    inline double degrees(double radians) {
        return radians * (180.0 / M_PI);
    }

    inline double radians(double degrees) {
        return degrees * (M_PI / 180.0);
    }
    // Arm dimensions (mm). Standard AL5D arm, as measured by Johnathan and Stormy
#define BASE_HGT 69.0       // Base height to X/Y plane
#define HUMERUS 146.0       // Shoulder-to-elbow "bone"
#define ULNA 184.5          // Elbow-to-wrist "bone"
#define GRIPPER 72.0        // Gripper length, to middle of grip surface

// Set physical limits (in degrees) per servo/joint.
// Will vary for each servo/joint, depending on mechanical range of motion.
// The MID setting is the required servo input needed to achieve a
// 90 degree joint angle, to allow compensation for horn misalignment
#define BAS_MIN 0.0         // Fully CCW
#define BAS_MID 90.0
#define BAS_MAX 180.0       // Fully CW

#define SHL_MIN 20.0        // Max forward motion
#define SHL_MID 81.0
#define SHL_MAX 140.0       // Max rearward motion

#define ELB_MIN 20.0        // Max upward motion
#define ELB_MID 88.0
#define ELB_MAX 165.0       // Max downward motion

#define WRI_MIN 0.0         // Max downward motion
#define WRI_MID 93.0
#define WRI_MAX 180.0       // Max upward motion

#define GRI_MIN 25.0        // Fully open
#define GRI_MID 90.0
#define GRI_MAX 165.0       // Fully closed

#define SERVO_MIN_US 600
#define SERVO_MAX_US 2400
   
// Speed adjustment parameters
// Percentages (1.0 = 100%) - applied to all arm movements
#define SPEED_MIN 0.5
#define SPEED_MAX 1.5
#define SPEED_DEFAULT 1.0
#define SPEED_INCREMENT 0.25

// IK function return values
#define IK_SUCCESS 0
#define IK_ERROR 1          // Desired position not possible

// Arm parking positions
#define PARK_MIDPOINT 1     // Servos at midpoints
#define PARK_READY 2        // Arm at Ready-To-Run position

// Ready-To-Run arm position. See descriptions below
// NOTE: Have the arm near this position before turning on the
//       servo power to prevent whiplash
#define READY_X 0.0
#define READY_Y 170.0
#define READY_Z 45.0
#define READY_GA 0.0
#define READY_G GRI_MID

// Global variables for arm position, and initial settings
// float X = READY_X;         // Left/right distance (mm) from base centerline - 0 is straight
// float Y = READY_Y;          // Distance (mm) out from base center
// float Z = READY_Z;          // Height (mm) from surface (i.e. X/Y plane)
// float GA = READY_GA;        // Gripper angle. Servo degrees, relative to X/Y plane - 0 is horizontal
// float G = READY_G;          // Gripper jaw opening. Servo degrees - midpoint is halfway open
// float Speed = SPEED_DEFAULT;

// Pre-calculations
    float hum_sq = HUMERUS*HUMERUS;
    float uln_sq = ULNA*ULNA;
};

