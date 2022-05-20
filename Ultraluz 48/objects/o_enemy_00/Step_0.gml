

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
		if _col_damage && alarm[2]	== -1{
			damage_to_enemy(10,5,2*_col_damage.image_xscale,0,15)
			if en_health <= 0 {
				en_state	= en_st.death
				image_index		= 0
				sprite_index	= s_en_00_death
			}
		} else if instance_exists(o_player) && distance_to_point(o_player.x,o_player.y) < 96 && alarm[0] == -1 {
			hdir		= sign(o_player.x-x)
			image_index	= 0
			en_state	= en_st.preatk
			spd[0]		= 0
		} else {
			var _random	= irandom_range(0,60)
			if _random = 60 {
				var _ran_flip	= irandom_range(0,2)
				if _ran_flip == 0 hdir*=-1
				else {
					en_state	= en_st.walk
					image_index		= 0
					sprite_index	= s_en_00_walk
				}
			}
		}
		
		sprite_index	= s_en_00_idle
		
        break
    case en_st.walk:
		if _col_damage && alarm[2]	== -1{
			damage_to_enemy(10,5,2*_col_damage.image_xscale,0,15)
			if en_health <= 0 {
				en_state	= en_st.death
				image_index		= 0
				sprite_index	= s_en_00_death
			}
		} else if instance_exists(o_player) && distance_to_point(o_player.x,o_player.y) < 96 && alarm[0] == -1 {
			hdir		= sign(o_player.x-x)
			image_index	= 0
			en_state	= en_st.preatk
		} else {
			var _fall	= !place_meeting(x+18*hdir,y+1,o_solid)
			if _fall hdir	*= -1
			
			spd[h]			= hdir*spd_max[h]
			
			var _random	= irandom_range(0,60)
			if _random = 60 {
				var _ran_flip	= irandom_range(0,2)
				if _ran_flip == 0 hdir*=-1
				else {
					spd[h]			= 0
					en_state		= en_st.idle
					image_index		= 0
					sprite_index	= s_en_00_idle
				}
			}
		}

		sprite_index	= s_en_00_walk
		
        break
	case en_st.preatk:
		if _col_damage && alarm[2]	== -1 {
			damage_to_enemy(10,5,2*_col_damage.image_xscale,0,15)
			if en_health <= 0 {
				en_state	= en_st.death
				image_index		= 0
				sprite_index	= s_en_00_death
			}
		}		
		sprite_index	= s_en_00_atk
		if image_index >= 7 && instance_exists(o_player) {
			atk_dash		= 2//clamp(linear_int(128,7,16,1,distance_to_object(o_player)),0,7)
			var _atk			= instance_create_depth(x*hdir,y,depth,o_en_00_atk)
			_atk.image_xscale	= hdir
			_atk.en_id			= id
			spd_push[h]	= atk_dash*hdir
			en_state	= en_st.atk
			alarm[0]	= ATK_ABS_COOLDOWN
		}
		break
	case en_st.atk:
		if _col_damage {
			instance_destroy(_col_damage)
			if instance_exists(o_player) && sign(o_player.x-x) != hdir && alarm[2]	== -1 {
				damage_to_enemy(10,5,2*_col_damage.image_xscale,0,15)
				
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


