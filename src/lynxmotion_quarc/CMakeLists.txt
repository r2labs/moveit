cmake_minimum_required(VERSION 2.8.3)

project(lynxmotion_quarc)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

add_service_files(
  FILES
  user_input.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
  quarc_user_interface
)

catkin_package(CATKIN_DEPENDS quarc_user_interface)

foreach(dir launch urdf)
  install(
    DIRECTORY ${dir}/
    DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach()
