bol_floor	= place_meeting(x,y+1,o_solid)
bol_hit		= instance_place(x,y,o_p_damage)

var _front	= det_front + 16*(state == en_st.shield)
var _mid	= (det_behind+_front)/2
var _x		= _front-_mid

bol_player	= collision_rectangle(x+_x*hdir_d-_mid,y-64,x+_x*hdir_d+_mid,y+8,o_player,false,true)


spd_final[h]	= spd[h] + spd_push[h]
spd_final[v]	= spd[v] + spd_push[v]

spd_push[h]	= approach(spd_push[h],0,.2)
spd_push[v]	= approach(spd_push[v],0,.2)

repeat (abs(spd_final[h]*COL_TIME)*game_spd) {
	if place_meeting(x+sign(spd_final[h]),y,o_solid) {
		spd[h]	= 0
		break
	} else x += sign(spd_final[h])/COL_TIME
}

repeat (abs(spd_final[v]*COL_TIME)*game_spd) {
	if place_meeting(x,y+sign(spd_final[v]),o_solid) {
		spd[v]	= 0
		break
	}  else y += sign(spd_final[v])/COL_TIME
}


st_ev[state]()

timers_system()

image_speed	= im_speed*game_spd

hdir_r	= approach(hdir_r,hdir,reaction_time*2)

if abs(hdir_r) == 1 hdir_d = hdir_r

