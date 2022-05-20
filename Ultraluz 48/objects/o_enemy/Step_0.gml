bol_floor	= place_meeting(x,y+1,o_solid)
if !bol_floor {
	spd[v]	= approach(spd[v],spd_max[v],spd_acc[v])
}

var _col_bullet	= collision_circle(x,y-48,64,o_bullet,false,true)

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
		if _col_bullet {
			shield_time	= 30
			hdir		= sign(_col_bullet.x-x)
			en_state	= en_st.shield
		} else if distance_to_point(o_player.x,o_player.y) < 128 && alarm[0] == -1 {
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
		if !instance_exists(shield) {
			shield		= instance_create_depth(x+16*hdir,y,depth,o_en_shield)
		}
		
		shield_time--
		
		if _col_bullet {
			shield_time	= SHIELD_ABS_TIME + random_range(-2,10)
		} else if shield_time <= 0 {
			shield_time	= 0
			en_state	= en_st.idle
			
		}
		
		sprite_index	= s_en_00_shield
		break
	case en_st.preatk:
		sprite_index	= s_en_00_atk
		if image_index >= 7 {
			atk_dash		= clamp(linear_int(128,7,16,2,distance_to_object(o_player)),0,7)
			var _atk			= instance_create_depth(x*hdir,y,depth,o_en_00_atk)
			_atk.image_xscale	= hdir
			_atk.en_id			= id
			spd_push[h]	= atk_dash*hdir
			en_state	= en_st.atk
			alarm[0]	= ATK_ABS_COOLDOWN
		}
		break
	case en_st.atk:
		if animation_end() {
			en_state	= en_st.idle
		}
		break
}


if instance_exists(shield) && en_state != en_st.shield {
	instance_destroy(shield)
}

if en_health <= 0 instance_destroy()
