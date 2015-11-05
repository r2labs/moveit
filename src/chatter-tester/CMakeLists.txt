cmake_minimum_required(VERSION 2.8.3)
project(chatter_tester)

find_package(catkin REQUIRED COMPONENTS roscpp sensor_msgs trajectory_msgs)

catkin_package(
   # INCLUDE_DIRS include
   LIBRARIES chatter_driver chatter_driver
   CATKIN_DEPENDS roscpp
)

include_directories(include
  ${catkin_INCLUDE_DIRS}
)

add_library(chatter src/chatter.cpp)
target_link_libraries(chatter ${catkin_LIBRARIES})

add_library(chatter_driver src/chatter_driver.cpp)
target_link_libraries(chatter_driver chatter ${catkin_LIBRARIES})

add_executable(chatter_node src/chatter_node.cpp)
target_link_libraries(chatter_node chatter_driver ${catkin_LIBRARIES})

install(TARGETS chatter chatter_driver chatter_node
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
