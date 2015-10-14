; Auto-generated. Do not edit!


(cl:in-package moveit_msgs-msg)


;//! \htmlinclude PositionIKRequest.msg.html

(cl:defclass <PositionIKRequest> (roslisp-msg-protocol:ros-message)
  ((group_name
    :reader group_name
    :initarg :group_name
    :type cl:string
    :initform "")
   (robot_state
    :reader robot_state
    :initarg :robot_state
    :type moveit_msgs-msg:RobotState
    :initform (cl:make-instance 'moveit_msgs-msg:RobotState))
   (constraints
    :reader constraints
    :initarg :constraints
    :type moveit_msgs-msg:Constraints
    :initform (cl:make-instance 'moveit_msgs-msg:Constraints))
   (avoid_collisions
    :reader avoid_collisions
    :initarg :avoid_collisions
    :type cl:boolean
    :initform cl:nil)
   (ik_link_name
    :reader ik_link_name
    :initarg :ik_link_name
    :type cl:string
    :initform "")
   (pose_stamped
    :reader pose_stamped
    :initarg :pose_stamped
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped))
   (ik_link_names
    :reader ik_link_names
    :initarg :ik_link_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (pose_stamped_vector
    :reader pose_stamped_vector
    :initarg :pose_stamped_vector
    :type (cl:vector geometry_msgs-msg:PoseStamped)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:PoseStamped :initial-element (cl:make-instance 'geometry_msgs-msg:PoseStamped)))
   (timeout
    :reader timeout
    :initarg :timeout
    :type cl:real
    :initform 0)
   (attempts
    :reader attempts
    :initarg :attempts
    :type cl:integer
    :initform 0))
)

(cl:defclass PositionIKRequest (<PositionIKRequest>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PositionIKRequest>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PositionIKRequest)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name moveit_msgs-msg:<PositionIKRequest> is deprecated: use moveit_msgs-msg:PositionIKRequest instead.")))

(cl:ensure-generic-function 'group_name-val :lambda-list '(m))
(cl:defmethod group_name-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:group_name-val is deprecated.  Use moveit_msgs-msg:group_name instead.")
  (group_name m))

(cl:ensure-generic-function 'robot_state-val :lambda-list '(m))
(cl:defmethod robot_state-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:robot_state-val is deprecated.  Use moveit_msgs-msg:robot_state instead.")
  (robot_state m))

(cl:ensure-generic-function 'constraints-val :lambda-list '(m))
(cl:defmethod constraints-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:constraints-val is deprecated.  Use moveit_msgs-msg:constraints instead.")
  (constraints m))

(cl:ensure-generic-function 'avoid_collisions-val :lambda-list '(m))
(cl:defmethod avoid_collisions-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:avoid_collisions-val is deprecated.  Use moveit_msgs-msg:avoid_collisions instead.")
  (avoid_collisions m))

(cl:ensure-generic-function 'ik_link_name-val :lambda-list '(m))
(cl:defmethod ik_link_name-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:ik_link_name-val is deprecated.  Use moveit_msgs-msg:ik_link_name instead.")
  (ik_link_name m))

(cl:ensure-generic-function 'pose_stamped-val :lambda-list '(m))
(cl:defmethod pose_stamped-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:pose_stamped-val is deprecated.  Use moveit_msgs-msg:pose_stamped instead.")
  (pose_stamped m))

(cl:ensure-generic-function 'ik_link_names-val :lambda-list '(m))
(cl:defmethod ik_link_names-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:ik_link_names-val is deprecated.  Use moveit_msgs-msg:ik_link_names instead.")
  (ik_link_names m))

(cl:ensure-generic-function 'pose_stamped_vector-val :lambda-list '(m))
(cl:defmethod pose_stamped_vector-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:pose_stamped_vector-val is deprecated.  Use moveit_msgs-msg:pose_stamped_vector instead.")
  (pose_stamped_vector m))

(cl:ensure-generic-function 'timeout-val :lambda-list '(m))
(cl:defmethod timeout-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:timeout-val is deprecated.  Use moveit_msgs-msg:timeout instead.")
  (timeout m))

(cl:ensure-generic-function 'attempts-val :lambda-list '(m))
(cl:defmethod attempts-val ((m <PositionIKRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader moveit_msgs-msg:attempts-val is deprecated.  Use moveit_msgs-msg:attempts instead.")
  (attempts m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PositionIKRequest>) ostream)
  "Serializes a message object of type '<PositionIKRequest>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'group_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'group_name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'robot_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'constraints) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'avoid_collisions) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'ik_link_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'ik_link_name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose_stamped) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ik_link_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'ik_link_names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pose_stamped_vector))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pose_stamped_vector))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'timeout)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'timeout) (cl:floor (cl:slot-value msg 'timeout)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let* ((signed (cl:slot-value msg 'attempts)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PositionIKRequest>) istream)
  "Deserializes a message object of type '<PositionIKRequest>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'group_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'group_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'robot_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'constraints) istream)
    (cl:setf (cl:slot-value msg 'avoid_collisions) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ik_link_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'ik_link_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose_stamped) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ik_link_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ik_link_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pose_stamped_vector) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pose_stamped_vector)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:PoseStamped))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timeout) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'attempts) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PositionIKRequest>)))
  "Returns string type for a message object of type '<PositionIKRequest>"
  "moveit_msgs/PositionIKRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PositionIKRequest)))
  "Returns string type for a message object of type 'PositionIKRequest"
  "moveit_msgs/PositionIKRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PositionIKRequest>)))
  "Returns md5sum for a message object of type '<PositionIKRequest>"
  "9936dc239c90af180ec94a51596c96f2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PositionIKRequest)))
  "Returns md5sum for a message object of type 'PositionIKRequest"
  "9936dc239c90af180ec94a51596c96f2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PositionIKRequest>)))
  "Returns full string definition for message of type '<PositionIKRequest>"
  (cl:format cl:nil "# A Position IK request message~%~%# The name of the group which will be used to compute IK~%# e.g. \"right_arm\", or \"arms\" - see IK specification for multiple-groups below~%# Information from the SRDF will be used to automatically determine which link ~%# to solve IK for, unless ik_link_name is also specified~%string group_name~%~%# A RobotState consisting of hint/seed positions for the IK computation and positions ~%# for all the other joints in the robot. Additional state information provided here is ~%# used to specify starting positions for other joints/links on the robot.  ~%# This state MUST contain state for all joints to be used by the IK solver~%# to compute IK. The list of joints that the IK solver deals with can be ~%# found using the SRDF for the corresponding group~%moveit_msgs/RobotState robot_state~%~%# A set of constraints that the IK must obey; by default, this set of constraints is empty~%Constraints constraints~%~%# Find an IK solution that avoids collisions. By default, this is false~%bool avoid_collisions~%~%# (OPTIONAL) The name of the link for which we are computing IK~%# If not specified, the link name will be inferred from a combination ~%# of the group name and the SRDF. If any values are specified for ik_link_names,~%# this value is ignored~%string ik_link_name~%~%# The stamped pose of the link, when the IK solver computes the joint values~%# for all the joints in a group. This value is ignored if pose_stamped_vector~%# has any elements specified.~%geometry_msgs/PoseStamped pose_stamped~%~%# Multi-group parameters~%~%# (OPTIONAL) The names of the links for which we are computing IK~%# If not specified, the link name will be inferred from a combination ~%# of the group name and the SRDF~%string[] ik_link_names~%~%# (OPTIONAL) The (stamped) poses of the links we are computing IK for (when a group has more than one end effector)~%# e.g. The \"arms\" group might consist of both the \"right_arm\" and the \"left_arm\"~%# The order of the groups referred to is the same as the order setup in the SRDF~%geometry_msgs/PoseStamped[] pose_stamped_vector~%~%# Maximum allowed time for IK calculation~%duration timeout~%~%# Maximum number of IK attempts (if using random seeds; leave as 0 for the default value specified on the param server to be used)~%int32 attempts~%~%~%================================================================================~%MSG: moveit_msgs/RobotState~%# This message contains information about the robot state, i.e. the positions of its joints and links~%sensor_msgs/JointState joint_state~%~%# Joints that may have multiple DOF are specified here~%sensor_msgs/MultiDOFJointState multi_dof_joint_state~%~%# Attached collision objects (attached to some link on the robot)~%AttachedCollisionObject[] attached_collision_objects~%~%# Flag indicating whether this scene is to be interpreted as a diff with respect to some other scene~%# This is mostly important for handling the attached bodies (whether or not to clear the attached bodies~%# of a moveit::core::RobotState before updating it with this message)~%bool is_diff~%~%================================================================================~%MSG: sensor_msgs/JointState~%# This is a message that holds data to describe the state of a set of torque controlled joints. ~%#~%# The state of each joint (revolute or prismatic) is defined by:~%#  * the position of the joint (rad or m),~%#  * the velocity of the joint (rad/s or m/s) and ~%#  * the effort that is applied in the joint (Nm or N).~%#~%# Each joint is uniquely identified by its name~%# The header specifies the time at which the joint states were recorded. All the joint states~%# in one message have to be recorded at the same time.~%#~%# This message consists of a multiple arrays, one for each part of the joint state. ~%# The goal is to make each of the fields optional. When e.g. your joints have no~%# effort associated with them, you can leave the effort array empty. ~%#~%# All arrays in this message should have the same size, or be empty.~%# This is the only way to uniquely associate the joint name with the correct~%# states.~%~%~%Header header~%~%string[] name~%float64[] position~%float64[] velocity~%float64[] effort~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/MultiDOFJointState~%# Representation of state for joints with multiple degrees of freedom, ~%# following the structure of JointState.~%#~%# It is assumed that a joint in a system corresponds to a transform that gets applied ~%# along the kinematic chain. For example, a planar joint (as in URDF) is 3DOF (x, y, yaw)~%# and those 3DOF can be expressed as a transformation matrix, and that transformation~%# matrix can be converted back to (x, y, yaw)~%#~%# Each joint is uniquely identified by its name~%# The header specifies the time at which the joint states were recorded. All the joint states~%# in one message have to be recorded at the same time.~%#~%# This message consists of a multiple arrays, one for each part of the joint state. ~%# The goal is to make each of the fields optional. When e.g. your joints have no~%# wrench associated with them, you can leave the wrench array empty. ~%#~%# All arrays in this message should have the same size, or be empty.~%# This is the only way to uniquely associate the joint name with the correct~%# states.~%~%Header header~%~%string[] joint_names~%geometry_msgs/Transform[] transforms~%geometry_msgs/Twist[] twist~%geometry_msgs/Wrench[] wrench~%~%================================================================================~%MSG: geometry_msgs/Transform~%# This represents the transform between two coordinate frames in free space.~%~%Vector3 translation~%Quaternion rotation~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Wrench~%# This represents force in free space, separated into~%# its linear and angular parts.~%Vector3  force~%Vector3  torque~%~%================================================================================~%MSG: moveit_msgs/AttachedCollisionObject~%# The CollisionObject will be attached with a fixed joint to this link~%string link_name~%~%#This contains the actual shapes and poses for the CollisionObject~%#to be attached to the link~%#If action is remove and no object.id is set, all objects~%#attached to the link indicated by link_name will be removed~%CollisionObject object~%~%# The set of links that the attached objects are allowed to touch~%# by default - the link_name is already considered by default~%string[] touch_links~%~%# If certain links were placed in a particular posture for this object to remain attached ~%# (e.g., an end effector closing around an object), the posture necessary for releasing~%# the object is stored here~%trajectory_msgs/JointTrajectory detach_posture~%~%# The weight of the attached object, if known~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/CollisionObject~%# a header, used for interpreting the poses~%Header header~%~%# the id of the object (name used in MoveIt)~%string id~%~%# The object type in a database of known objects~%object_recognition_msgs/ObjectType type~%~%# the the collision geometries associated with the object;~%# their poses are with respect to the specified header~%~%# solid geometric primitives~%shape_msgs/SolidPrimitive[] primitives~%geometry_msgs/Pose[] primitive_poses~%~%# meshes~%shape_msgs/Mesh[] meshes~%geometry_msgs/Pose[] mesh_poses~%~%# bounding planes (equation is specified, but the plane can be oriented using an additional pose)~%shape_msgs/Plane[] planes~%geometry_msgs/Pose[] plane_poses~%~%# Adds the object to the planning scene. If the object previously existed, it is replaced.~%byte ADD=0~%~%# Removes the object from the environment entirely (everything that matches the specified id)~%byte REMOVE=1~%~%# Append to an object that already exists in the planning scene. If the does not exist, it is added.~%byte APPEND=2~%~%# If an object already exists in the scene, new poses can be sent (the geometry arrays must be left empty)~%# if solely moving the object is desired~%byte MOVE=3~%~%# Operation to be performed~%byte operation~%~%================================================================================~%MSG: object_recognition_msgs/ObjectType~%################################################## OBJECT ID #########################################################~%~%# Contains information about the type of a found object. Those two sets of parameters together uniquely define an~%# object~%~%# The key of the found object: the unique identifier in the given db~%string key~%~%# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding~%# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"~%# There is no conventional format for those parameters and it's nice to keep that flexibility.~%# The object_recognition_core as a generic DB type that can read those fields~%# Current examples:~%# For CouchDB:~%#   type: 'CouchDB'~%#   root: 'http://localhost:5984'~%#   collection: 'object_recognition'~%# For SQL household database:~%#   type: 'SqlHousehold'~%#   host: 'wgs36'~%#   port: 5432~%#   user: 'willow'~%#   password: 'willow'~%#   name: 'household_objects'~%#   module: 'tabletop'~%string db~%~%================================================================================~%MSG: shape_msgs/SolidPrimitive~%# Define box, sphere, cylinder, cone ~%# All shapes are defined to have their bounding boxes centered around 0,0,0.~%~%uint8 BOX=1~%uint8 SPHERE=2~%uint8 CYLINDER=3~%uint8 CONE=4~%~%# The type of the shape~%uint8 type~%~%~%# The dimensions of the shape~%float64[] dimensions~%~%# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array~%~%# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding~%# sides of the box.~%uint8 BOX_X=0~%uint8 BOX_Y=1~%uint8 BOX_Z=2~%~%~%# For the SPHERE type, only one component is used, and it gives the radius of~%# the sphere.~%uint8 SPHERE_RADIUS=0~%~%~%# For the CYLINDER and CONE types, the center line is oriented along~%# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component~%# of dimensions gives the height of the cylinder (cone).  The~%# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the~%# radius of the base of the cylinder (cone).  Cone and cylinder~%# primitives are defined to be circular. The tip of the cone is~%# pointing up, along +Z axis.~%~%uint8 CYLINDER_HEIGHT=0~%uint8 CYLINDER_RADIUS=1~%~%uint8 CONE_HEIGHT=0~%uint8 CONE_RADIUS=1~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: shape_msgs/Mesh~%# Definition of a mesh~%~%# list of triangles; the index values refer to positions in vertices[]~%MeshTriangle[] triangles~%~%# the actual vertices that make up the mesh~%geometry_msgs/Point[] vertices~%~%================================================================================~%MSG: shape_msgs/MeshTriangle~%# Definition of a triangle's vertices~%uint32[3] vertex_indices~%~%================================================================================~%MSG: shape_msgs/Plane~%# Representation of a plane, using the plane equation ax + by + cz + d = 0~%~%# a := coef[0]~%# b := coef[1]~%# c := coef[2]~%# d := coef[3]~%~%float64[4] coef~%~%================================================================================~%MSG: trajectory_msgs/JointTrajectory~%Header header~%string[] joint_names~%JointTrajectoryPoint[] points~%================================================================================~%MSG: trajectory_msgs/JointTrajectoryPoint~%# Each trajectory point specifies either positions[, velocities[, accelerations]]~%# or positions[, effort] for the trajectory to be executed.~%# All specified values are in the same order as the joint names in JointTrajectory.msg~%~%float64[] positions~%float64[] velocities~%float64[] accelerations~%float64[] effort~%duration time_from_start~%~%================================================================================~%MSG: moveit_msgs/Constraints~%# This message contains a list of motion planning constraints.~%# All constraints must be satisfied for a goal to be considered valid~%~%string name~%~%JointConstraint[] joint_constraints~%~%PositionConstraint[] position_constraints~%~%OrientationConstraint[] orientation_constraints~%~%VisibilityConstraint[] visibility_constraints~%~%================================================================================~%MSG: moveit_msgs/JointConstraint~%# Constrain the position of a joint to be within a certain bound~%string joint_name~%~%# the bound to be achieved is [position - tolerance_below, position + tolerance_above]~%float64 position~%float64 tolerance_above~%float64 tolerance_below~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%================================================================================~%MSG: moveit_msgs/PositionConstraint~%# This message contains the definition of a position constraint.~%~%Header header~%~%# The robot link this constraint refers to~%string link_name~%~%# The offset (in the link frame) for the target point on the link we are planning for~%geometry_msgs/Vector3 target_point_offset~%~%# The volume this constraint refers to ~%BoundingVolume constraint_region~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/BoundingVolume~%# Define a volume in 3D~%~%# A set of solid geometric primitives that make up the volume to define (as a union)~%shape_msgs/SolidPrimitive[] primitives~%~%# The poses at which the primitives are located~%geometry_msgs/Pose[] primitive_poses~%~%# In addition to primitives, meshes can be specified to add to the bounding volume (again, as union)~%shape_msgs/Mesh[] meshes~%~%# The poses at which the meshes are located~%geometry_msgs/Pose[] mesh_poses~%~%================================================================================~%MSG: moveit_msgs/OrientationConstraint~%# This message contains the definition of an orientation constraint.~%~%Header header~%~%# The desired orientation of the robot link specified as a quaternion~%geometry_msgs/Quaternion orientation~%~%# The robot link this constraint refers to~%string link_name~%~%# optional axis-angle error tolerances specified~%float64 absolute_x_axis_tolerance~%float64 absolute_y_axis_tolerance~%float64 absolute_z_axis_tolerance~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/VisibilityConstraint~%# The constraint is useful to maintain visibility to a disc (the target) in a particular frame.~%# This disc forms the base of a visibiliy cone whose tip is at the origin of the sensor.~%# Maintaining visibility is done by ensuring the robot does not obstruct the visibility cone.~%# Note:~%# This constraint does NOT enforce minimum or maximum distances between the sensor~%# and the target, nor does it enforce the target to be in the field of view of~%# the sensor. A PositionConstraint can (and probably should) be used for such purposes.~%~%# The radius of the disc that should be maintained visible ~%float64 target_radius~%~%# The pose of the disc; as the robot moves, the pose of the disc may change as well~%# This can be in the frame of a particular robot link, for example~%geometry_msgs/PoseStamped target_pose~%~%# From the sensor origin towards the target, the disc forms a visibility cone~%# This cone is approximated using many sides. For example, when using 4 sides, ~%# that in fact makes the visibility region be a pyramid.~%# This value should always be 3 or more.~%int32 cone_sides~%~%# The pose in which visibility is to be maintained.~%# The frame id should represent the robot link to which the sensor is attached.~%# It is assumed the sensor can look directly at the target, in any direction.~%# This assumption is usually not true, but additional PositionConstraints~%# can resolve this issue.~%geometry_msgs/PoseStamped sensor_pose~%~%# Even though the disc is maintained visible, the visibility cone can be very small~%# because of the orientation of the disc with respect to the sensor. It is possible~%# for example to view the disk almost from a side, in which case the visibility cone ~%# can end up having close to 0 volume. The view angle is defined to be the angle between~%# the normal to the visibility disc and the direction vector from the sensor origin.~%# The value below represents the minimum desired view angle. For a perfect view,~%# this value will be 0 (the two vectors are exact opposites). For a completely obstructed view~%# this value will be Pi/2 (the vectors are perpendicular). This value defined below ~%# is the maximum view angle to be maintained. This should be a value in the open interval~%# (0, Pi/2). If 0 is set, the view angle is NOT enforced.~%float64 max_view_angle~%~%# This angle is used similarly to max_view_angle but limits the maximum angle~%# between the sensor origin direction vector and the axis that connects the~%# sensor origin to the target frame origin. The value is again in the range (0, Pi/2)~%# and is NOT enforced if set to 0.~%float64 max_range_angle~%~%# The axis that is assumed to indicate the direction of view for the sensor~%# X = 2, Y = 1, Z = 0~%uint8 SENSOR_Z=0~%uint8 SENSOR_Y=1~%uint8 SENSOR_X=2~%uint8 sensor_view_direction~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PositionIKRequest)))
  "Returns full string definition for message of type 'PositionIKRequest"
  (cl:format cl:nil "# A Position IK request message~%~%# The name of the group which will be used to compute IK~%# e.g. \"right_arm\", or \"arms\" - see IK specification for multiple-groups below~%# Information from the SRDF will be used to automatically determine which link ~%# to solve IK for, unless ik_link_name is also specified~%string group_name~%~%# A RobotState consisting of hint/seed positions for the IK computation and positions ~%# for all the other joints in the robot. Additional state information provided here is ~%# used to specify starting positions for other joints/links on the robot.  ~%# This state MUST contain state for all joints to be used by the IK solver~%# to compute IK. The list of joints that the IK solver deals with can be ~%# found using the SRDF for the corresponding group~%moveit_msgs/RobotState robot_state~%~%# A set of constraints that the IK must obey; by default, this set of constraints is empty~%Constraints constraints~%~%# Find an IK solution that avoids collisions. By default, this is false~%bool avoid_collisions~%~%# (OPTIONAL) The name of the link for which we are computing IK~%# If not specified, the link name will be inferred from a combination ~%# of the group name and the SRDF. If any values are specified for ik_link_names,~%# this value is ignored~%string ik_link_name~%~%# The stamped pose of the link, when the IK solver computes the joint values~%# for all the joints in a group. This value is ignored if pose_stamped_vector~%# has any elements specified.~%geometry_msgs/PoseStamped pose_stamped~%~%# Multi-group parameters~%~%# (OPTIONAL) The names of the links for which we are computing IK~%# If not specified, the link name will be inferred from a combination ~%# of the group name and the SRDF~%string[] ik_link_names~%~%# (OPTIONAL) The (stamped) poses of the links we are computing IK for (when a group has more than one end effector)~%# e.g. The \"arms\" group might consist of both the \"right_arm\" and the \"left_arm\"~%# The order of the groups referred to is the same as the order setup in the SRDF~%geometry_msgs/PoseStamped[] pose_stamped_vector~%~%# Maximum allowed time for IK calculation~%duration timeout~%~%# Maximum number of IK attempts (if using random seeds; leave as 0 for the default value specified on the param server to be used)~%int32 attempts~%~%~%================================================================================~%MSG: moveit_msgs/RobotState~%# This message contains information about the robot state, i.e. the positions of its joints and links~%sensor_msgs/JointState joint_state~%~%# Joints that may have multiple DOF are specified here~%sensor_msgs/MultiDOFJointState multi_dof_joint_state~%~%# Attached collision objects (attached to some link on the robot)~%AttachedCollisionObject[] attached_collision_objects~%~%# Flag indicating whether this scene is to be interpreted as a diff with respect to some other scene~%# This is mostly important for handling the attached bodies (whether or not to clear the attached bodies~%# of a moveit::core::RobotState before updating it with this message)~%bool is_diff~%~%================================================================================~%MSG: sensor_msgs/JointState~%# This is a message that holds data to describe the state of a set of torque controlled joints. ~%#~%# The state of each joint (revolute or prismatic) is defined by:~%#  * the position of the joint (rad or m),~%#  * the velocity of the joint (rad/s or m/s) and ~%#  * the effort that is applied in the joint (Nm or N).~%#~%# Each joint is uniquely identified by its name~%# The header specifies the time at which the joint states were recorded. All the joint states~%# in one message have to be recorded at the same time.~%#~%# This message consists of a multiple arrays, one for each part of the joint state. ~%# The goal is to make each of the fields optional. When e.g. your joints have no~%# effort associated with them, you can leave the effort array empty. ~%#~%# All arrays in this message should have the same size, or be empty.~%# This is the only way to uniquely associate the joint name with the correct~%# states.~%~%~%Header header~%~%string[] name~%float64[] position~%float64[] velocity~%float64[] effort~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/MultiDOFJointState~%# Representation of state for joints with multiple degrees of freedom, ~%# following the structure of JointState.~%#~%# It is assumed that a joint in a system corresponds to a transform that gets applied ~%# along the kinematic chain. For example, a planar joint (as in URDF) is 3DOF (x, y, yaw)~%# and those 3DOF can be expressed as a transformation matrix, and that transformation~%# matrix can be converted back to (x, y, yaw)~%#~%# Each joint is uniquely identified by its name~%# The header specifies the time at which the joint states were recorded. All the joint states~%# in one message have to be recorded at the same time.~%#~%# This message consists of a multiple arrays, one for each part of the joint state. ~%# The goal is to make each of the fields optional. When e.g. your joints have no~%# wrench associated with them, you can leave the wrench array empty. ~%#~%# All arrays in this message should have the same size, or be empty.~%# This is the only way to uniquely associate the joint name with the correct~%# states.~%~%Header header~%~%string[] joint_names~%geometry_msgs/Transform[] transforms~%geometry_msgs/Twist[] twist~%geometry_msgs/Wrench[] wrench~%~%================================================================================~%MSG: geometry_msgs/Transform~%# This represents the transform between two coordinate frames in free space.~%~%Vector3 translation~%Quaternion rotation~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Wrench~%# This represents force in free space, separated into~%# its linear and angular parts.~%Vector3  force~%Vector3  torque~%~%================================================================================~%MSG: moveit_msgs/AttachedCollisionObject~%# The CollisionObject will be attached with a fixed joint to this link~%string link_name~%~%#This contains the actual shapes and poses for the CollisionObject~%#to be attached to the link~%#If action is remove and no object.id is set, all objects~%#attached to the link indicated by link_name will be removed~%CollisionObject object~%~%# The set of links that the attached objects are allowed to touch~%# by default - the link_name is already considered by default~%string[] touch_links~%~%# If certain links were placed in a particular posture for this object to remain attached ~%# (e.g., an end effector closing around an object), the posture necessary for releasing~%# the object is stored here~%trajectory_msgs/JointTrajectory detach_posture~%~%# The weight of the attached object, if known~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/CollisionObject~%# a header, used for interpreting the poses~%Header header~%~%# the id of the object (name used in MoveIt)~%string id~%~%# The object type in a database of known objects~%object_recognition_msgs/ObjectType type~%~%# the the collision geometries associated with the object;~%# their poses are with respect to the specified header~%~%# solid geometric primitives~%shape_msgs/SolidPrimitive[] primitives~%geometry_msgs/Pose[] primitive_poses~%~%# meshes~%shape_msgs/Mesh[] meshes~%geometry_msgs/Pose[] mesh_poses~%~%# bounding planes (equation is specified, but the plane can be oriented using an additional pose)~%shape_msgs/Plane[] planes~%geometry_msgs/Pose[] plane_poses~%~%# Adds the object to the planning scene. If the object previously existed, it is replaced.~%byte ADD=0~%~%# Removes the object from the environment entirely (everything that matches the specified id)~%byte REMOVE=1~%~%# Append to an object that already exists in the planning scene. If the does not exist, it is added.~%byte APPEND=2~%~%# If an object already exists in the scene, new poses can be sent (the geometry arrays must be left empty)~%# if solely moving the object is desired~%byte MOVE=3~%~%# Operation to be performed~%byte operation~%~%================================================================================~%MSG: object_recognition_msgs/ObjectType~%################################################## OBJECT ID #########################################################~%~%# Contains information about the type of a found object. Those two sets of parameters together uniquely define an~%# object~%~%# The key of the found object: the unique identifier in the given db~%string key~%~%# The db parameters stored as a JSON/compressed YAML string. An object id does not make sense without the corresponding~%# database. E.g., in object_recognition, it can look like: \"{'type':'CouchDB', 'root':'http://localhost'}\"~%# There is no conventional format for those parameters and it's nice to keep that flexibility.~%# The object_recognition_core as a generic DB type that can read those fields~%# Current examples:~%# For CouchDB:~%#   type: 'CouchDB'~%#   root: 'http://localhost:5984'~%#   collection: 'object_recognition'~%# For SQL household database:~%#   type: 'SqlHousehold'~%#   host: 'wgs36'~%#   port: 5432~%#   user: 'willow'~%#   password: 'willow'~%#   name: 'household_objects'~%#   module: 'tabletop'~%string db~%~%================================================================================~%MSG: shape_msgs/SolidPrimitive~%# Define box, sphere, cylinder, cone ~%# All shapes are defined to have their bounding boxes centered around 0,0,0.~%~%uint8 BOX=1~%uint8 SPHERE=2~%uint8 CYLINDER=3~%uint8 CONE=4~%~%# The type of the shape~%uint8 type~%~%~%# The dimensions of the shape~%float64[] dimensions~%~%# The meaning of the shape dimensions: each constant defines the index in the 'dimensions' array~%~%# For the BOX type, the X, Y, and Z dimensions are the length of the corresponding~%# sides of the box.~%uint8 BOX_X=0~%uint8 BOX_Y=1~%uint8 BOX_Z=2~%~%~%# For the SPHERE type, only one component is used, and it gives the radius of~%# the sphere.~%uint8 SPHERE_RADIUS=0~%~%~%# For the CYLINDER and CONE types, the center line is oriented along~%# the Z axis.  Therefore the CYLINDER_HEIGHT (CONE_HEIGHT) component~%# of dimensions gives the height of the cylinder (cone).  The~%# CYLINDER_RADIUS (CONE_RADIUS) component of dimensions gives the~%# radius of the base of the cylinder (cone).  Cone and cylinder~%# primitives are defined to be circular. The tip of the cone is~%# pointing up, along +Z axis.~%~%uint8 CYLINDER_HEIGHT=0~%uint8 CYLINDER_RADIUS=1~%~%uint8 CONE_HEIGHT=0~%uint8 CONE_RADIUS=1~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: shape_msgs/Mesh~%# Definition of a mesh~%~%# list of triangles; the index values refer to positions in vertices[]~%MeshTriangle[] triangles~%~%# the actual vertices that make up the mesh~%geometry_msgs/Point[] vertices~%~%================================================================================~%MSG: shape_msgs/MeshTriangle~%# Definition of a triangle's vertices~%uint32[3] vertex_indices~%~%================================================================================~%MSG: shape_msgs/Plane~%# Representation of a plane, using the plane equation ax + by + cz + d = 0~%~%# a := coef[0]~%# b := coef[1]~%# c := coef[2]~%# d := coef[3]~%~%float64[4] coef~%~%================================================================================~%MSG: trajectory_msgs/JointTrajectory~%Header header~%string[] joint_names~%JointTrajectoryPoint[] points~%================================================================================~%MSG: trajectory_msgs/JointTrajectoryPoint~%# Each trajectory point specifies either positions[, velocities[, accelerations]]~%# or positions[, effort] for the trajectory to be executed.~%# All specified values are in the same order as the joint names in JointTrajectory.msg~%~%float64[] positions~%float64[] velocities~%float64[] accelerations~%float64[] effort~%duration time_from_start~%~%================================================================================~%MSG: moveit_msgs/Constraints~%# This message contains a list of motion planning constraints.~%# All constraints must be satisfied for a goal to be considered valid~%~%string name~%~%JointConstraint[] joint_constraints~%~%PositionConstraint[] position_constraints~%~%OrientationConstraint[] orientation_constraints~%~%VisibilityConstraint[] visibility_constraints~%~%================================================================================~%MSG: moveit_msgs/JointConstraint~%# Constrain the position of a joint to be within a certain bound~%string joint_name~%~%# the bound to be achieved is [position - tolerance_below, position + tolerance_above]~%float64 position~%float64 tolerance_above~%float64 tolerance_below~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%================================================================================~%MSG: moveit_msgs/PositionConstraint~%# This message contains the definition of a position constraint.~%~%Header header~%~%# The robot link this constraint refers to~%string link_name~%~%# The offset (in the link frame) for the target point on the link we are planning for~%geometry_msgs/Vector3 target_point_offset~%~%# The volume this constraint refers to ~%BoundingVolume constraint_region~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/BoundingVolume~%# Define a volume in 3D~%~%# A set of solid geometric primitives that make up the volume to define (as a union)~%shape_msgs/SolidPrimitive[] primitives~%~%# The poses at which the primitives are located~%geometry_msgs/Pose[] primitive_poses~%~%# In addition to primitives, meshes can be specified to add to the bounding volume (again, as union)~%shape_msgs/Mesh[] meshes~%~%# The poses at which the meshes are located~%geometry_msgs/Pose[] mesh_poses~%~%================================================================================~%MSG: moveit_msgs/OrientationConstraint~%# This message contains the definition of an orientation constraint.~%~%Header header~%~%# The desired orientation of the robot link specified as a quaternion~%geometry_msgs/Quaternion orientation~%~%# The robot link this constraint refers to~%string link_name~%~%# optional axis-angle error tolerances specified~%float64 absolute_x_axis_tolerance~%float64 absolute_y_axis_tolerance~%float64 absolute_z_axis_tolerance~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: moveit_msgs/VisibilityConstraint~%# The constraint is useful to maintain visibility to a disc (the target) in a particular frame.~%# This disc forms the base of a visibiliy cone whose tip is at the origin of the sensor.~%# Maintaining visibility is done by ensuring the robot does not obstruct the visibility cone.~%# Note:~%# This constraint does NOT enforce minimum or maximum distances between the sensor~%# and the target, nor does it enforce the target to be in the field of view of~%# the sensor. A PositionConstraint can (and probably should) be used for such purposes.~%~%# The radius of the disc that should be maintained visible ~%float64 target_radius~%~%# The pose of the disc; as the robot moves, the pose of the disc may change as well~%# This can be in the frame of a particular robot link, for example~%geometry_msgs/PoseStamped target_pose~%~%# From the sensor origin towards the target, the disc forms a visibility cone~%# This cone is approximated using many sides. For example, when using 4 sides, ~%# that in fact makes the visibility region be a pyramid.~%# This value should always be 3 or more.~%int32 cone_sides~%~%# The pose in which visibility is to be maintained.~%# The frame id should represent the robot link to which the sensor is attached.~%# It is assumed the sensor can look directly at the target, in any direction.~%# This assumption is usually not true, but additional PositionConstraints~%# can resolve this issue.~%geometry_msgs/PoseStamped sensor_pose~%~%# Even though the disc is maintained visible, the visibility cone can be very small~%# because of the orientation of the disc with respect to the sensor. It is possible~%# for example to view the disk almost from a side, in which case the visibility cone ~%# can end up having close to 0 volume. The view angle is defined to be the angle between~%# the normal to the visibility disc and the direction vector from the sensor origin.~%# The value below represents the minimum desired view angle. For a perfect view,~%# this value will be 0 (the two vectors are exact opposites). For a completely obstructed view~%# this value will be Pi/2 (the vectors are perpendicular). This value defined below ~%# is the maximum view angle to be maintained. This should be a value in the open interval~%# (0, Pi/2). If 0 is set, the view angle is NOT enforced.~%float64 max_view_angle~%~%# This angle is used similarly to max_view_angle but limits the maximum angle~%# between the sensor origin direction vector and the axis that connects the~%# sensor origin to the target frame origin. The value is again in the range (0, Pi/2)~%# and is NOT enforced if set to 0.~%float64 max_range_angle~%~%# The axis that is assumed to indicate the direction of view for the sensor~%# X = 2, Y = 1, Z = 0~%uint8 SENSOR_Z=0~%uint8 SENSOR_Y=1~%uint8 SENSOR_X=2~%uint8 sensor_view_direction~%~%# A weighting factor for this constraint (denotes relative importance to other constraints. Closer to zero means less important)~%float64 weight~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PositionIKRequest>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'group_name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'robot_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'constraints))
     1
     4 (cl:length (cl:slot-value msg 'ik_link_name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose_stamped))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ik_link_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pose_stamped_vector) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PositionIKRequest>))
  "Converts a ROS message object to a list"
  (cl:list 'PositionIKRequest
    (cl:cons ':group_name (group_name msg))
    (cl:cons ':robot_state (robot_state msg))
    (cl:cons ':constraints (constraints msg))
    (cl:cons ':avoid_collisions (avoid_collisions msg))
    (cl:cons ':ik_link_name (ik_link_name msg))
    (cl:cons ':pose_stamped (pose_stamped msg))
    (cl:cons ':ik_link_names (ik_link_names msg))
    (cl:cons ':pose_stamped_vector (pose_stamped_vector msg))
    (cl:cons ':timeout (timeout msg))
    (cl:cons ':attempts (attempts msg))
))
