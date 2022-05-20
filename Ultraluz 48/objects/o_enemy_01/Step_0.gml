bol_floor	= place_meeting(x,y+1,o_solid)
if !bol_floor {
	spd[v]	= approach(spd[v],spd_max[v],spd_acc[v])
}

var _col_damage	= instance_place(x,y,o_p_damage)

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

image_xscale	= hdir



switch (en_state) {
    case en_st.idle:
		if _col_damage {
			instance_destroy(_col_damage)
			if sign(o_player.x-x) == hdir {
				shield_time	= SHIELD_ABS_TIME + random_range(-2,10)
				hdir		= sign(o_player.x-x)
				en_state	= en_st.shield
				image_index		= 0
				sprite_index	= s_en_00_shield
			} else if alarm[2]	== -1{
				spd_push		= [2*_col_damage.image_xscale,0]
				alarm[2]		= 15
				en_health		-= 10
					
				if en_health <= 0 {
					en_state	= en_st.death
					image_index		= 0
					sprite_index	= s_en_00_death
				}
			}
		} else if distance_to_point(o_player.x,o_player.y) < 96 && alarm[0] == -1 {
			hdir		= sign(o_player.x-x)
			image_index	= 0
			en_state	= en_st.preatk
		}
		
		sprite_index	= s_en_00_idle
		
        break
    case en_st.walk:
		sprite_index	= s_en_00_walk
		
        break
	case en_st.shield:
		if _col_damage {
			instance_destroy(_col_damage)
			if sign(o_player.x-x) == hdir {
				shield_time	= SHIELD_ABS_TIME + random_range(-2,10)
			} else if alarm[2]	== -1 {
				spd_push		= [2*_col_damage.image_xscale,0]
				alarm[2]		= 15
				en_health		-= 10
					
				if en_health <= 0 {
					en_state	= en_st.death
					image_index		= 0
					sprite_index	= s_en_00_death
				}
			}
		} 
		
		if animation_end() image_speed	= 0
		
		shield_time--
		
		if shield_time <= 0 {
			shield_time	= 0
			image_speed	= 1
			en_state	= en_st.idle
			
		}
		
		sprite_index	= s_en_00_shield
		break
	case en_st.preatk:
		if _col_damage {
			instance_destroy(_col_damage)
			if sign(o_player.x-x) == hdir {
				shield_time	= SHIELD_ABS_TIME + random_range(-2,10)
				hdir		= sign(o_player.x-x)
				en_state	= en_st.shield
				image_index		= 0
				sprite_index	= s_en_00_shield
			} else if alarm[2]	== -1 {
				spd_push		= [2*_col_damage.image_xscale,0]
				alarm[2]		= 15
				en_health		-= 10
					
				if en_health <= 0 {
					en_state	= en_st.death
					image_index		= 0
					sprite_index	= s_en_00_death
				}
			}
		} 
		
		sprite_index	= s_en_00_atk
		if image_index >= 7 {
			atk_dash		= clamp(linear_int(128,7,16,1,distance_to_object(o_player)),0,7)
			var _atk			= instance_create_depth(x*hdir,y,depth,o_en_00_atk)
			_atk.image_xscale	= hdir
			_atk.en_id			= id
			//spd_push[h]	= atk_dash*hdir
			en_state	= en_st.atk
			alarm[0]	= ATK_ABS_COOLDOWN
		}
		break
	case en_st.atk:
		if _col_damage {
			instance_destroy(_col_damage)
			if sign(o_player.x-x) != hdir && alarm[2]	== -1 {
				spd_push		= [2*_col_damage.image_xscale,0]
				alarm[2]		= 15
				en_health		-= 10
				
				if en_health <= 0 {
					en_state	= en_st.death
					image_index		= 0
					sprite_index	= s_en_00_death
				}
			}
		} 
	
		if animation_end() {
			en_state	= en_st.idle
		}
		break
	case en_st.death:
		sprite_index	= s_en_00_death
		image_speed		= 1
		if animation_end() {
			instance_destroy()
		}
		break
}
