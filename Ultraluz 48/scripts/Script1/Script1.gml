function approach(_init, _value, _amount) {
	if _init < _value
		return min(_amount + _init, _value)
	else
		return max(_init - _amount, _value)
}

function animation_end() {
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}


function linear_int(x0,y0,x1,y1,value) {
	return y0 + (value-x0)*(y1-y0)/(x1-x0)
}

function damage_to_enemy(_dmg, _shake, hpush, vpush, _atk_cooldown) {
	en_health		-= _dmg
	shake			= _shake
	spd_push		= [hpush,vpush]
	alarm[2]		= _atk_cooldown
}
