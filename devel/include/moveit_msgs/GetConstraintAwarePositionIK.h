// Generated by gencpp from file moveit_msgs/GetConstraintAwarePositionIK.msg
// DO NOT EDIT!


#ifndef MOVEIT_MSGS_MESSAGE_GETCONSTRAINTAWAREPOSITIONIK_H
#define MOVEIT_MSGS_MESSAGE_GETCONSTRAINTAWAREPOSITIONIK_H

#include <ros/service_traits.h>


#include <moveit_msgs/GetConstraintAwarePositionIKRequest.h>
#include <moveit_msgs/GetConstraintAwarePositionIKResponse.h>


namespace moveit_msgs
{

struct GetConstraintAwarePositionIK
{

typedef GetConstraintAwarePositionIKRequest Request;
typedef GetConstraintAwarePositionIKResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct GetConstraintAwarePositionIK
} // namespace moveit_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIK > {
  static const char* value()
  {
    return "9d77c923462bf6a8c411e685f149e1da";
  }

  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIK&) { return value(); }
};

template<>
struct DataType< ::moveit_msgs::GetConstraintAwarePositionIK > {
  static const char* value()
  {
    return "moveit_msgs/GetConstraintAwarePositionIK";
  }

  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIK&) { return value(); }
};


// service_traits::MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIKRequest> should match 
// service_traits::MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIK > 
template<>
struct MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIKRequest>
{
  static const char* value()
  {
    return MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIK >::value();
  }
  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIKRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::moveit_msgs::GetConstraintAwarePositionIKRequest> should match 
// service_traits::DataType< ::moveit_msgs::GetConstraintAwarePositionIK > 
template<>
struct DataType< ::moveit_msgs::GetConstraintAwarePositionIKRequest>
{
  static const char* value()
  {
    return DataType< ::moveit_msgs::GetConstraintAwarePositionIK >::value();
  }
  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIKRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIKResponse> should match 
// service_traits::MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIK > 
template<>
struct MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIKResponse>
{
  static const char* value()
  {
    return MD5Sum< ::moveit_msgs::GetConstraintAwarePositionIK >::value();
  }
  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIKResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::moveit_msgs::GetConstraintAwarePositionIKResponse> should match 
// service_traits::DataType< ::moveit_msgs::GetConstraintAwarePositionIK > 
template<>
struct DataType< ::moveit_msgs::GetConstraintAwarePositionIKResponse>
{
  static const char* value()
  {
    return DataType< ::moveit_msgs::GetConstraintAwarePositionIK >::value();
  }
  static const char* value(const ::moveit_msgs::GetConstraintAwarePositionIKResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // MOVEIT_MSGS_MESSAGE_GETCONSTRAINTAWAREPOSITIONIK_H
