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
    if [[ -n $4 ]]; then
        ga=$4
    fi
    ungrip
    move_arm ${1} ${2} 120 $4
    sleep 1
    move_arm ${1} ${2} ${3} $4
    sleep 1
    grip
    sleep 1;
    move_arm ${1} ${2} 120 $4
}

function place {
    local ga=-90
    if [[ -n $4 ]]; then
        ga=$4
    fi
    move_arm ${1} ${2} 120 $4
    sleep 1
    move_arm ${1} ${2} ${3} $4
    sleep 1
    ungrip
    sleep 1
    move_arm ${1} ${2} 120 $4
}

function rest {
    move_arm 0 150 150 0
}
