function move_arm {
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=${3}"
    sleep 0.005
}

function grip {
    curl "http://localhost:8080/grip?g=1.0"
    sleep 0.005
}

function ungrip {
    curl "http://localhost:8080/grip?g=0.0"
    sleep 0.005
}

function pick {
    ungrip
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=120"
    sleep 1
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=${3}"
    sleep 1
    grip
    sleep 1;
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=120"
}

function place {
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=120"
    sleep 1
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=${3}"
    sleep 1
    ungrip
    sleep 1;
    curl "http://localhost:8080/goto?x=${1}&y=${2}&z=120"
}
