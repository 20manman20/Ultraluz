function interval_is_off(argument0, argument1) {
	var _value = argument0;
	var _interval = argument1;

	return (_value % _interval) <= _interval/2;


}
if interval_is_off(alarm[2], 16) {
	gpu_set_fog(false, c_white, 0, 1)
} else {
	gpu_set_fog(true, c_white, 0, 1)
}

draw_self()

gpu_set_fog(false, c_white, 0, 1)
//draw_circle(x,y-48,64,true)

//draw_circle(x,y-48,128,true)
