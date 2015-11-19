function domino {
    rest
    local num_dom=${1}
    last_y=$((330 - num_dom*30 - 30))
    for i in {1..${num_dom}}; do
             pick -140 0 $((10* (num_dom - i + 1))) -90
             sleep 1
             place 0 $((330 - (i*30))) 30 0
             sleep 1;
    done
    move_arm 0 ${last_y} 30 0
    sleep 1;
    grip
    sleep 1;
    move_arm 0 $((last_y+40)) 30 0
    sleep 1;
    rest
}
