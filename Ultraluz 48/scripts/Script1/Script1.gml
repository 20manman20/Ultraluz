function approach(_init, _value, _amount) {
	if _init < _value
		return min(_amount + _init, _value)
	else
		return max(_init - _amount, _value)
}

function animation_end() {
	return (image_index + im_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}


function linear_int(x0,y0,x1,y1,value) {
	return y0 + (value-x0)*(y1-y0)/(x1-x0)
}

function damage_to_enemy(_dmg, _shake, hpush, vpush, _atk_cooldown) {
	en_health		-= _dmg
	hdir			= sign(bol_hit.x-x)
	shake			= _shake
	game_spd		= 0
	o_camera.alarm[1]	= 2
	spd_push		= [hpush,vpush]
	timer[2]		= _atk_cooldown
}

function timers_system() {
	for (var i = 0; i < timer_amount; ++i) {
		timer[i]		= approach(timer[i],-1,game_spd)
		if timer[i] == 0 timer_ev[i]()
	}
}

function event_damage() {
	if bol_hit && timer[2]	== -1 {
		damage_to_enemy(10,5,5*bol_hit.image_xscale,-2,-1)

		if en_health <= 0 {
			state	= en_st.death
			image_index		= 0
			sprite_index	= s_en_00_death
		}
	}
	return (bol_hit && timer[2]	== -1)
}

