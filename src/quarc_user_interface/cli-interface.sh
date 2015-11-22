function move_arm {
    local ga=-90
    if [[ -n $4 ]]; then
        ga=$4
    fi
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=${3}&gripper_angle_degrees=${ga}"
    sleep 0.005
}

function grip {
    local g=1
    if [[ -n $1 ]]; then
        g=$1
    fi
    curl "http://localhost:8080/grip?gripper_percent=${g}"
    sleep 0.005
}

function ungrip {
    curl "http://localhost:8080/ungrip"
    sleep 0.005
}

function pick {
    local ga=-90
    local z=10
    if [[ -n $3 ]]; then
        ga=$3
    fi
    if [[ -n $4 ]]; then
        ga=$4
    fi
    curl "http://localhost:8080/pick?x=${1}&y=${2}&z=${z}&gripper_angle_degrees=${ga}"
}

function dinodrop {
    curl "http://localhost:8080/dinodrop"
}

function place {
    local ga="-90"
    local z="100"
    if [[ -n $3 ]]; then
        z=$4
    fi
    if [[ -n $4 ]]; then
        ga=$4
    fi
    curl "http://localhost:8080/place?x=${1}&y=${2}&z=${z}&gripper_angle_degrees=${ga}"
}

function rest {
    curl "http://localhost:8080/rest"
}
