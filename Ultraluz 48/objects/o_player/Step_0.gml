//Las variables locales siempre llevarán "_" antes del nombre
//Variables de tecla
key_left	= keyboard_check(vk_left)
key_right	= keyboard_check(vk_right)

key_atk		= keyboard_check_pressed(ord("Z"))

key_jump	= keyboard_check_pressed(ord("X"))
key_jump_r	= keyboard_check_released(ord("X"))

key_dash	= keyboard_check_pressed(ord("C"))
key_dash_r	= keyboard_check_released(ord("C"))

spd[h]	= approach(spd[h], _input*spd_max[h], spd_acc[h])

bol_floor	= place_meeting(x,y+1,o_solid)

spd_final[h]	= spd[h] + spd_push[h]
spd_final[v]	= spd[v] + spd_push[v]

spd_push[h]	= approach(spd_push[h],0,.2)
spd_push[v]	= approach(spd_push[v],0,.2)

repeat (abs(spd_final[h]*COL_TIME)) {
	if place_meeting(x+sign(spd_final[h]),y,o_solid) {
		spd[h]	= 0
		break
	} else x += sign(spd_final[h])/COL_TIME
}

repeat (abs(spd_final[v]*COL_TIME)) {
	if place_meeting(x,y+sign(spd_final[v]),o_solid) {
		spd[v]	= 0
		break
	}  else y += sign(spd_final[v])/COL_TIME
}

switch (p_state) {
    case p_st.idle:
		event_jump()
		event_wall_hang()
		event_gravity()
		 
		_input		= key_right - key_left
		if _input != 0 hdir	= _input
	
		sprite_index	= s_p_idle
		image_speed		= 1
		
		if abs(spd[h]) > 0 {
			p_state	= p_st.run
		}
		
		if key_atk {
			if alarm[1] > -1 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				sprite_index	= s_p_atk_01
				p_state		= p_st.atk_01
			} else {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_00
				sprite_index	= s_p_atk_00
			}
			image_index	= 0
		}
		
        break;
		
		
     case p_st.run:
		event_jump()
		event_wall_hang()
		event_gravity()
		
		_input		= key_right - key_left
		if _input != 0 hdir	= _input
	 
		sprite_index	= s_p_run
		if _input == 0 {
			image_speed	= abs(spd[h])/spd_max[h]
			if spd[h] == 0	p_state		= p_st.idle
		} else if _input = -sign(spd[h]) {
			p_state		= p_st.trn_ar
			image_index	= 0
			sprite_index	= s_p_turn_around
		} else image_speed		= 1
		
		if key_dash {
			p_state		= p_st.dash
			image_index	= 0
			sprite_index	= s_p_slide_back
			spd[h]		= 0
			spd_push[h]	= dash_spd*hdir
		} else if key_atk {
			if alarm[1] > -1 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				sprite_index	= s_p_atk_01
				p_state		= p_st.atk_01
			} else {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_00
				sprite_index	= s_p_atk_00
			}
			image_index	= 0
		}
		
        break;
	case p_st.trn_ar:
		event_jump()
		event_wall_hang()
		event_gravity()
		
		_input		= key_right - key_left
		if _input != 0 hdir	= _input
		
		sprite_index	= s_p_turn_around
		image_speed		= 1
		
		if key_dash {
			p_state		= p_st.dash
			image_index	= 0
			sprite_index	= s_p_slide_back
			spd[h]		= 0
			spd_push[h]	= dash_spd*hdir
		} else if key_atk {
			if alarm[1] > -1 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				sprite_index	= s_p_atk_01
				p_state		= p_st.atk_01
			} else {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_00
				sprite_index	= s_p_atk_00
			}
			image_index	= 0
		}  else if spd[h]	== 0 {
			p_state		= p_st.idle
		}
		
		if animation_end() {
			p_state	= p_st.run
		}
		break
	case p_st.jump:
		event_jump()
		event_wall_hang()
		event_gravity()
		
		_input		= key_right - key_left

		if _input != 0 hdir	= _input
		
		sprite_index	= s_p_jump
		image_speed		= 1
		
		if key_dash {
			p_state		= p_st.roll
			image_index	= 0
			sprite_index	= s_p_roll_throw
			spd[h]		= 0
			spd_push[h]	= 6*hdir
			
		} else if spd[v] > -.3 {
			p_state	= p_st.jmp_fll
			image_index	= 0
			sprite_index	= s_p_jmp_fll
		}
		break
	case p_st.jmp_fll:
		event_wall_hang()
		event_gravity()
		
		_input		= key_right - key_left

		if _input != 0 hdir	= _input
		
		sprite_index	= s_p_jmp_fll
		image_speed		= 1
		
		if key_dash {
			p_state		= p_st.roll
			image_index	= 0
			sprite_index	= s_p_roll_throw
			spd[h]		= 0
			spd_push[h]	= 6*hdir
		} else if animation_end() {
			p_state		= p_st.fall
			image_index	= 0
			sprite_index	= s_p_fall
		}
		break
	case p_st.fall:
		event_wall_hang()
		event_gravity()
		
		_input		= key_right - key_left

		if _input != 0 hdir	= _input
		
		sprite_index	= s_p_fall
		image_speed		= 1
		
		if bol_floor {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		
		break
		
	case p_st.atk_00:
		event_gravity()
		
		if image_index > 2 event_jump()
		
		sprite_index	= s_p_atk_00
		image_speed		= 1
		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
			alarm[1]		= 10
			if buffer_atk > 0 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_01
				image_index	= 0
				sprite_index	= s_p_atk_01
			}
		} else if key_atk && image_index > 2 {
			buffer_atk = buffer_atk_max
		}
		break
	case p_st.atk_01:
		event_gravity()
		
		if image_index > 2 event_jump()
		sprite_index	= s_p_atk_01
		image_speed		= 1
		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		break
	case p_st.dash:
		event_gravity()
		event_wall_hang()
		
		if key_dash_r spd_push[h]*=.5
		image_speed	= 1
		if animation_end() {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		
		break
	case p_st.roll:
		event_gravity()
		event_wall_hang()
		
		_input		= key_right - key_left
		if animation_end() {
			image_speed	= 0
		}
		
		if bol_floor {
			p_state		= p_st.roll_land
			image_index		= 0
			image_speed		= 1
			sprite_index	= s_p_roll_land
		}
		break
	case p_st.roll_land:
		buffer	= 0
		jumped	= true
		event_gravity()
		event_wall_hang()
		
		if animation_end() {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		break
	case p_st.death:
		break
	case p_st.hit:
		event_wall_hang()
		event_gravity()
		
		spd[h]			= 0
		
		sprite_index	= s_p_hit
		if hit_time > 0 {
			hit_time--
		} else {
			if _input != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		break
	case p_st.wall_hang: 
		var _wall	= instance_place(x+hdir*4,y,o_solid)
		if _wall {
			var _xcorner	= _wall.x+_wall.image_xscale*64*(1-hdir)/2
			var _ycorner	= _wall.y
			x	= _xcorner-8*hdir
			y	= _ycorner+28
		}
		
		spd[v]	= 0
		spd[h]	= 0
		_input	= 0
		sprite_index	= s_p_wall_hang
		
		if key_jump {
			p_state	= p_st.wall_climb
			sprite_index	= s_p_wall_climb
			image_index		= 0
			/*
			p_state	= p_st.jump
			spd[v] = -spd_max[v]/1.3
			spd[h] = hdir*2
			*/
		}
		
		break
	case p_st.wall_climb:
		if animation_end() {
			image_speed	= 0
			x	+= 15
			y	-= 28
			sprite_index	= s_p_idle
			p_state	= p_st.idle
		}
		break
}

if buffer_atk > 0 {
	buffer_atk--
}

if place_meeting(x, y+1, o_solid) && !place_meeting(x, yprevious+1, o_solid) {
	i_scale[h] = 1.4
	i_scale[v] = .8
	
}

i_scale[h]	= lerp(i_scale[h],1,.2)
i_scale[v]	= lerp(i_scale[v],1,.2)

if p_health <= 10 {
	instance_destroy()
}

