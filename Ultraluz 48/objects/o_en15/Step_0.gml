bol_hit		= instance_place(x,y,o_p_damage)

spd_final[h]	= spd[h] + spd_push[h]
spd_final[v]	= spd[v] + spd_push[v]

spd_push[h]	= approach(spd_push[h],0,1)
spd_push[v]	= approach(spd_push[v],0,1)

repeat (abs(spd_final[h]*COL_TIME)*game_spd) {
	if place_meeting(x+sign(spd_final[h]),y,o_solid) {
		spd[h]	= 0
		im_dir += 15
		break
	} else x += sign(spd_final[h])/COL_TIME
}

repeat (abs(spd_final[v]*COL_TIME)*game_spd) {
	if place_meeting(x,y+sign(spd_final[v]),o_solid) {
		spd[v]	= 0
		im_dir += 15
		break
	}  else y += sign(spd_final[v])/COL_TIME
}

st_ev[state]()
timers_system()

image_speed	= im_speed*game_spd

