#region Iniciar variables
//Inicio macros
#macro	h				0
#macro	v				1
#macro	COL_TIME		10
#macro	HIT_ABS_TIME	30

//Input de velocidad horizontal
hinput			= 1
hinput_prev		= hinput

//Velocidad en x y
spd			= [0,0]
spd_push	= [0,0]

//Velocidad máxima al correr
//Velocidad máxima al caer
spd_max		= [2.5,7.5]

//Aceleración
//Gravedad
spd_acc		= [.2,.3]

key_left	= keyboard_check(ord("A"))
key_right	= keyboard_check(ord("D"))
key_jump	= keyboard_check_pressed(ord("W"))
key_jump_r	= keyboard_check_released(ord("W"))

//Colgar
grapple			= [0,0]
rope			= [0,0]
rope_angle		= 0
rope_length		= 0
rope_angle_spd	= 0
rope_acc		= 0.2

//Ataques
coyote_atk_max	= 20
coyote_atk		= 0
coyote_atk_i	= 1

buffer_atk_max	= 20
buffer_atk		= 0
buffer_atk_i	= 1

//Tiempo que dura golpeado
hit_time		= 0

//Velocidad del dash
dash_spd		= 7

//Escalado de imagen
//Velocidad de imagen
//Orientación Horizontal de imagen
im_scale			= [1,1]
im_speed	= 1
hdir			= 1

depth	-= 2

#endregion

#region Nombre de los estados
arr_p_st		= [	"idle",
					"run",
					"turn_around",
					"dash",
					"dash_back",
					"jump",
					"fall",
					"jump_fall",
					"roll_throw",
					"roll",
					"roll_throw_back",
					"roll_back",
					"wall_hang",
					"wall_climb",
					"atk_00",
					"atk_01",
					"atk_02",
					"atk_air_00",
					"atk_air_01",
					"atk_air_02",
					"atk_air_02_fall",
					"atk_air_02_land",
					"hit",
					"death",
					"swing"]

#endregion

#region Estados
enum p_st {
	idle,
	run,
	turn_around,
	dash,
	dash_back,
	jump,
	fall,
	jump_fall,
	roll_throw,
	roll,
	roll_throw_back,
	roll_back,
	wall_hang,
	wall_climb,
	atk_00,
	atk_01,
	atk_02,
	atk_air_00,
	atk_air_01,
	atk_air_02,
	atk_air_02_fall,
	atk_air_02_land,
	hit,
	death,
	swing
}

st_ev[p_st.idle]	= function() {
	event_p_collision()
	event_p_jump()
	event_p_wall_hang()
	event_gravity(true)
	event_p_hinput()
		
	event_animation(s_p_idle,1)
		
	if abs(spd[h]) > 0 {
		state	= p_st.run
	}
		
	if event_p_dash() {}
	else if event_p_attack() {}
		
}

st_ev[p_st.run]	= function() {
	event_p_collision()
	event_p_jump()
	event_p_wall_hang()
	event_gravity(true)
	event_p_hinput()
	 
	event_animation(s_p_run)
		
	if hinput == 0 {
		im_speed	= abs(spd[h])/spd_max[h]
		if spd[h] == 0	state		= p_st.idle
	} else if hinput = -sign(spd[h]) {
		state		= p_st.turn_around
		image_index	= 0
		sprite_index	= s_p_turn_around
	} else im_speed		= 1
		
	if event_p_dash() {}
	else if event_p_attack() {}
}

st_ev[p_st.turn_around]	= function() {
	event_p_collision()
	event_p_jump()
	event_p_wall_hang()
	event_gravity(true)
	event_p_hinput()
		
	event_animation(s_p_turn_around,1)
		
	if event_p_dash() {}
	else if event_p_attack() {}
	else if spd[h]	== 0 {
		state		= p_st.idle
	}
		
	if animation_end() {
		state	= p_st.run
	}
}

st_ev[p_st.dash]	= function() {
	event_p_collision()
	event_gravity(true)
	event_animation(s_p_roll_land,1)
	var _key_i	= key_right - key_left
		
	if image_index < 1 && _key_i == -hdir {
		spd_push[h]	= dash_spd*_key_i
		hdir		= _key_i
		state		= p_st.dash_back
	}
		
	if key_dash_r spd_push[h]*=.3
	im_speed	= 1
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	}
}

st_ev[p_st.dash_back]	= function() {
	event_p_collision()
	event_gravity(true)
	event_animation(s_p_roll_land64,1)
		
	if key_dash_r spd_push[h]*=.3
		
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	}
}

st_ev[p_st.jump]	= function() {
	event_p_collision()
	event_p_jump()
	event_p_wall_hang()
	event_gravity()
	event_p_hinput()
		
	event_animation(s_p_jump,1)
		
	if event_p_attack_air() {}
	else if key_dash {
		state		= p_st.roll_throw
		image_index	= 0
		sprite_index	= s_p_roll_throw
		spd[h]		= 0
		spd[h]		= 6*hdir
		spd[v]		= -2
			
	} else if spd[v] > -.3 {
		state	= p_st.jump_fall
		image_index	= 0
		sprite_index	= s_p_jump_fall
	}
}

st_ev[p_st.fall]	= function() {
	event_p_collision()
	event_p_wall_hang()
	event_gravity()
	event_p_hinput()
		
	event_animation(s_p_fall,1)
		
		
	if bol_floor {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	} else event_p_attack_air()
}

st_ev[p_st.jump_fall]	= function() {
	event_p_collision()
	event_p_wall_hang()
	event_gravity()
	event_p_hinput()
		
	event_animation(s_p_jump_fall,1)
		
	if event_p_attack_air() {}
	else if key_dash {
		state		= p_st.roll_throw
		image_index	= 0
		sprite_index	= s_p_roll_throw
		spd[h]		= 0
		spd[h]		= 6*hdir
		spd[v]		= -2
	} else if animation_end() {
		state		= p_st.fall
		image_index	= 0
		sprite_index	= s_p_fall
	}
}

st_ev[p_st.roll_throw]	= function() {
	event_p_collision()
	event_gravity()
	event_p_wall_hang()
	event_p_hinput(false,true,true,.15, .1)
	
		
	if animation_end() {
		im_speed	= 0
	}
		
	if bol_floor {
		state		= p_st.roll
		image_index		= 0
		im_speed		= 1
		sprite_index	= s_p_roll_land
	}
}

st_ev[p_st.roll]	= function() {
	event_p_collision()
	event_gravity()
	event_p_hinput(true,true,true,.2,.1)
	event_p_wall_hang()
		
	sprite_index	= s_p_roll_land
		
	event_p_attack()
		
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	}
}

st_ev[p_st.roll_throw_back]	= function() {
	
}

st_ev[p_st.roll_back]	= function() {
	
}

st_ev[p_st.wall_hang]	= function() {
	event_animation(s_p_wall_hang)
		
	var _wall	= instance_place(x+hdir*4,y,o_solid)
	if _wall {
		var _xcorner	= _wall.x+_wall.image_xscale*64*(1-hdir)/2
		var _ycorner	= _wall.y
		x	= _xcorner-8*hdir
		y	= _ycorner+28
	}
		
	spd[v]	= 0
	spd[h]	= 0
	
	var _k	= key_right_p - key_left_p
	
	if key_jump {
		spd[v]	= -spd_max[v]/1.3
		spd[h]	= hdir*spd_max[h]*2
		state	= p_st.jump
		
	} else if key_dash {
		y	-= 28
		event_p_dash()
	} else {
		if _k == hdir {
			state	= p_st.wall_climb
			sprite_index	= s_p_wall_climb
			image_index		= 0
			/*
			state	= p_st.jump
			spd[v] = -spd_max[v]/1.3
			spd[h] = hdir*2
			*/
		} else if _k == -hdir {
			x-=hdir
			state	= p_st.fall
		} 
	}
		
}

st_ev[p_st.wall_climb]	= function() {
	event_animation(s_p_wall_climb,1)
	/*
	if key_jump {
		spd[v]	= -spd_max[v]/1.3
		state	= p_st.jump
	} else 
	*/
	if animation_end() {
		im_speed	= 0
		x	+= 15*hdir
		y	-= 28
		sprite_index	= s_p_idle
		state	= p_st.idle
	}
}

st_ev[p_st.atk_00]	= function() {
	event_p_collision()
	event_gravity()
	event_animation(s_p_atk_00,1)
		
	if image_index > 2 event_p_jump()

	spd[h]			= lerp(spd[h],0,.2)
		
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
		coyote_atk		= coyote_atk_max
		coyote_atk_i	= 1
			
		if buffer_atk > 0 {
			var _atk	= instance_create_depth(x,y,depth,o_p_atk)
			_atk.image_xscale	= hdir
			state		= p_st.atk_00+buffer_atk_i
			image_index	= 0
			sprite_index	= s_p_atk_01
		}
	} else if image_index > 2 {
		if event_p_dash() {}
		else if key_atk { 
			buffer_atk		= buffer_atk_max
			buffer_atk_i	= 1
		}
	}
}

st_ev[p_st.atk_01]	= function() {
	event_p_collision()
	event_gravity()
	event_animation(s_p_atk_01,1)
		
	if image_index > 2 event_p_jump()
		
	spd[h]			= lerp(spd[h],0,.2)
		
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
		coyote_atk		= coyote_atk_max
		coyote_atk_i	= 2
			
		if buffer_atk > 0 {
			var _atk	= instance_create_depth(x,y,depth,o_p_atk)
			_atk.image_xscale	= hdir
			state		= p_st.atk_00+buffer_atk_i
			image_index	= 0
			sprite_index	= s_p_atk_02
		}
	} else if image_index > 2 {
		if event_p_dash() {}
		else if key_atk { 
			buffer_atk		= buffer_atk_max
			buffer_atk_i	= 2
		}
	}
}

st_ev[p_st.atk_02]	= function() {
	event_p_collision()
	event_gravity()
	event_animation(s_p_atk_02,1)
		
	if image_index > 2 event_p_jump()
	spd[h]			= lerp(spd[h],0,.2)
		
	if image_index > 2 {
		event_p_dash()
	}
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	}
		
}

st_ev[p_st.atk_air_00]	= function() {
	event_p_collision()
	event_animation(s_p_atk_00,1)

	spd[h]			= lerp(spd[h],0,.2)
		
	if animation_end() {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
		//alarm[1]		= 10
		if buffer_atk > 0 {
			var _atk	= instance_create_depth(x,y,depth,o_p_atk)
			_atk.image_xscale	= hdir
			state		= p_st.atk_01
			image_index	= 0
			sprite_index	= s_p_atk_01
		}
	} else if key_atk && image_index > 2 {
		buffer_atk = buffer_atk_max
	}
}

st_ev[p_st.atk_air_01]	= function() {
	
}

st_ev[p_st.atk_air_02]	= function() {
	event_p_collision()
	event_gravity()
	event_animation(s_p_atk_air_02,1)
		
	spd[h]			= lerp(spd[h],0,.2)
		
	if animation_end() {
		state	= p_st.atk_air_02_fall
		spd[v]	= 9
	}
}

st_ev[p_st.atk_air_02_fall]	= function() {
	event_p_collision()
	event_animation(s_p_atk_air_02_fall,1)
		if bol_floor state = p_st.atk_air_02_land
}

st_ev[p_st.atk_air_02_land]	= function() {
	event_p_collision()
	event_animation(s_p_atk_air_02_land,1)
	if animation_end() state = p_st.idle
}

st_ev[p_st.hit]	= function() {
	event_p_collision()
	event_gravity()
		
	spd[h]			= 0
		
	sprite_index	= s_p_hit
	if hit_time > 0 {
		hit_time--
	} else {
		if hinput != 0 state	= p_st.run
		else state	= p_st.idle
	}
}

st_ev[p_st.swing]	= function() {
	event_p_collision()
	event_animation(s_p_swing,1)
	image_angle	= point_direction(x,y,grapple[h],grapple[v])-90
	var _rope_angle_acc	= -rope_acc * dcos(rope_angle)
	_rope_angle_acc += (key_right-key_left)*0.03
	rope_length	+= (key_down-key_up)*0.5
	rope_angle_spd += _rope_angle_acc
	rope_angle += rope_angle_spd
	rope_angle_spd *= 0.97
		
	rope	= [grapple[h]+lengthdir_x(rope_length,rope_angle),grapple[v]+lengthdir_y(rope_length,rope_angle)]
	spd		= [rope[h]-x,rope[v]-y]
		
	if key_jump {
		im_scale[h] = .7
		im_scale[v] = 1.5
		state	= p_st.jump 
	}
}

st_ev[p_st.death]	= function() {
	
}



//Variables de estados
state			= p_st.idle

#endregion

#region Timers


#endregion
