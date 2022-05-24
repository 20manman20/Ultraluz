//draw_text(x,y-64,(sign(o_player.x-x) != hdir) && alarm[2] == -1 )

function interval_is_off(_value, _interval) {
	return (_value % _interval) <= _interval/4;

}

if interval_is_off(alarm[2], 16) || state == en_st.death {
	gpu_set_fog(false, c_white, 0, 1)
} else {
	gpu_set_fog(true, c_white, 0, 1)
}

draw_self()

gpu_set_fog(false, c_white, 0, 1)
//draw_circle(x,y-48,64,true)

//draw_circle(x,y-48,128,true)
