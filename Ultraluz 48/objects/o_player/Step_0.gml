//Las variables locales siempre llevarán "_" antes del nombre
//Variables de tecla
key_left	= keyboard_check(vk_left)
key_right	= keyboard_check(vk_right)

key_atk		= keyboard_check_pressed(ord("Z"))

key_jump	= keyboard_check_pressed(ord("X"))
key_jump_r	= keyboard_check_released(ord("X"))

key_dash	= keyboard_check_pressed(ord("C"))
key_dash_r	= keyboard_check_released(ord("C"))


bol_floor	= place_meeting(x,y+1,o_solid)

spd_final[h]	= spd[h] + spd_push[h]
spd_final[v]	= spd[v] + spd_push[v]

spd_push[h]	= approach(spd_push[h],0,.2)
spd_push[v]	= approach(spd_push[v],0,.2)

repeat (abs(spd_final[h]*COL_TIME)*game_spd) {
	if place_meeting(x+sign(spd_final[h]),y,o_solid) {
		if p_state	== p_st.swing {
			rope_angle	= point_direction(grapple[h],grapple[v],x,y)
			rope_angle_spd	= 0
		}
		spd[h]	= 0
		break
	} else x += sign(spd_final[h])/COL_TIME
}

repeat (abs(spd_final[v]*COL_TIME)*game_spd) {
	if place_meeting(x,y+sign(spd_final[v]),o_solid) {
		spd[v]	= 0
		if p_state	== p_st.swing {
			rope_angle	= point_direction(grapple[h],grapple[v],x,y)
			rope_angle_spd	= 0
		}
		break
	}  else y += sign(spd_final[v])/COL_TIME
}

switch (p_state) {
    case p_st.idle:
		event_jump()
		event_wall_hang()
		event_gravity(true)
		event_hinput()
		
		event_animation(s_p_idle,1)
		
		if abs(spd[h]) > 0 {
			p_state	= p_st.run
		}
		
		if event_dash() {}
		else if event_attack() {}
		
        break;
		
     case p_st.run:
		event_jump()
		event_wall_hang()
		event_gravity(true)
		event_hinput()
	 
		event_animation(s_p_run)
		
		if hinput == 0 {
			image_speed	= abs(spd[h])/spd_max[h]
			if spd[h] == 0	p_state		= p_st.idle
		} else if hinput = -sign(spd[h]) {
			p_state		= p_st.turn_around
			image_index	= 0
			sprite_index	= s_p_turn_around
		} else image_speed		= 1
		
		if event_dash() {}
		else if event_attack() {}
		
        break;
	case p_st.turn_around:
		event_jump()
		event_wall_hang()
		event_gravity(true)
		event_hinput()
		
		event_animation(s_p_turn_around,1)
		
		if event_dash() {}
		else if event_attack() {}
		else if spd[h]	== 0 {
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
		event_hinput()
		
		event_animation(s_p_jump,1)
		
		if event_attack_air() {}
		else if key_dash {
			p_state		= p_st.roll_throw
			image_index	= 0
			sprite_index	= s_p_roll_throw
			spd[h]		= 0
			spd[h]	= 6*hdir
			
		} else if spd[v] > -.3 {
			p_state	= p_st.jump_fall
			image_index	= 0
			sprite_index	= s_p_jump_fall
		}
		break
		
	case p_st.jump_fall:
		event_wall_hang()
		event_gravity()
		event_hinput()
		
		event_animation(s_p_jump_fall,1)
		
		if event_attack_air() {}
		else if key_dash {
			p_state		= p_st.roll_throw
			image_index	= 0
			sprite_index	= s_p_roll_throw
			spd[h]		= 0
			spd[h]	= 6*hdir
		} else if animation_end() {
			p_state		= p_st.fall
			image_index	= 0
			sprite_index	= s_p_fall
		}
		break
	case p_st.fall:
		event_wall_hang()
		event_gravity()
		event_hinput()
		
		event_animation(s_p_fall,1)
		
		
		if bol_floor {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		} else event_attack_air()
		
		break
		
	case p_st.atk_00:
		event_gravity()
		event_animation(s_p_atk_00,1)
		
		if image_index > 2 event_jump()

		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
			coyote_atk		= coyote_atk_max
			coyote_atk_i	= 1
			
			if buffer_atk > 0 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_00+buffer_atk_i
				image_index	= 0
				sprite_index	= s_p_atk_01
			}
		} else if key_atk && image_index > 2 {
			buffer_atk		= buffer_atk_max
			buffer_atk_i	= 1
		}
		break
		
	case p_st.atk_01:
		event_gravity()
		event_animation(s_p_atk_01,1)
		
		if image_index > 2 event_jump()
		
		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
			coyote_atk		= coyote_atk_max
			coyote_atk_i	= 2
			
			if buffer_atk > 0 {
				var _atk	= instance_create_depth(x+8,y,depth,o_bullet)
				_atk.image_xscale	= hdir
				p_state		= p_st.atk_00+buffer_atk_i
				image_index	= 0
				sprite_index	= s_p_atk_02
			}
		} else if key_atk && image_index > 2 {
			buffer_atk		= buffer_atk_max
			buffer_atk_i	= 2
		}
		
		break
	case p_st.atk_02:
		event_gravity()
		event_animation(s_p_atk_02,1)
		
		if image_index > 2 event_jump()
		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		
		break
		
	case p_st.dash:
		event_gravity(true)
		event_animation(s_p_roll_land,1)
		
		if key_dash_r spd_push[h]*=.3
		image_speed	= 1
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		
		break
	case p_st.dash_back:
		event_gravity(true)
		event_animation(s_p_roll_land64,1)
		
		if key_dash_r spd_push[h]*=.3
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		
		break
	case p_st.roll_throw:
		event_gravity()
		event_wall_hang()
		event_hinput(false,true,true,.15, .1)
	
		
		if animation_end() {
			image_speed	= 0
		}
		
		if bol_floor {
			p_state		= p_st.roll
			image_index		= 0
			image_speed		= 1
			sprite_index	= s_p_roll_land
		}
		break
	case p_st.roll:
		event_gravity()
		event_hinput(true,true,true,.2,.1)
		event_wall_hang()
		
		sprite_index	= s_p_roll_land
		
		event_attack()
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
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
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
		}
		break
	case p_st.wall_hang:
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
	case p_st.swing:
		event_animation(s_p_idle,1)
		var _rope_angle_acc	= -rope_acc * dcos(rope_angle)
		_rope_angle_acc += (key_right-key_left)*0.1
		rope_angle_spd += _rope_angle_acc
		rope_angle += rope_angle_spd
		rope_angle_spd *= 0.97
		
		rope	= [grapple[h]+lengthdir_x(rope_length,rope_angle),grapple[v]+lengthdir_y(rope_length,rope_angle)]
		spd		= [rope[h]-x,rope[v]-y]
		
		if key_jump {
			i_scale[h] = .7
			i_scale[v] = 1.5
			p_state	= p_st.jump 
		}
		
		break
	case p_st.atk_air_02:
		event_gravity()
		event_animation(s_p_atk_air_02,1)
		
		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			p_state	= p_st.atk_air_02_fall
			spd[v]	= 9
		}
		
		break
	case p_st.atk_air_00:
		
		event_animation(s_p_atk_00,1)

		spd[h]			= lerp(spd[h],0,.2)
		
		if animation_end() {
			if hinput != 0 p_state	= p_st.run
			else p_state	= p_st.idle
			//alarm[1]		= 10
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
	case p_st.atk_air_02_fall:
		event_animation(s_p_atk_air_02_fall,1)
		if bol_floor p_state = p_st.atk_air_02_land
		break
	case p_st.atk_air_02_land:
		event_animation(s_p_atk_air_02_land,1)
		if animation_end() p_state = p_st.idle
		break
}

if buffer_atk > 0 {
	buffer_atk--
}

if place_meeting(x, y+1, o_solid) && !place_meeting(x, yprevious+1, o_solid) {
	i_scale[h] = 1.3
	i_scale[v] = .7
	
}

i_scale[h]	= lerp(i_scale[h],1,.2)
i_scale[v]	= lerp(i_scale[v],1,.2)

if p_health <= 10 {
	instance_destroy()
}

if coyote_atk > 0 {
	coyote_atk--
}

