//Las variables locales siempre llevarán "_" antes del nombre
//Variables de tecla
key_left	= keyboard_check(vk_left)
key_right	= keyboard_check(vk_right)
key_up		= keyboard_check(vk_up)
key_down		= keyboard_check(vk_down)

key_left_p	= keyboard_check_pressed(vk_left)
key_right_p	= keyboard_check_pressed(vk_right)

key_atk		= keyboard_check_pressed(ord("Z"))

key_jump	= keyboard_check_pressed(ord("X"))
key_jump_r	= keyboard_check_released(ord("X"))

key_dash	= keyboard_check_pressed(ord("C"))
key_dash_r	= keyboard_check_released(ord("C"))

bol_roof	= place_meeting(x,y-2,o_solid)
bol_floor	= place_meeting(x,y+2,o_solid)

bol_slope	= place_meeting(x,y+2,o_slope)

spd_final[h]	= (spd[h] + spd_push[h])*(1-.2*bol_slope)
spd_final[v]	= (spd[v] + spd_push[v])*(1-.2*bol_slope)

if game_spd {
	spd_push[h]	= approach(spd_push[h],0,.2)
	spd_push[v]	= approach(spd_push[v],0,.2)
}

trail_alpha	= trail_alpha*.9

if !bol_floor {
	if coyote > 0 {
		coyote--
	}
} else {
	jumped	= false
	coyote	= coyote_max
}


if buffer > 0 {
	buffer--
}

st_ev[state]()

if spd[v] > 0 && place_meeting(x, y+spd[v], o_solid) && !place_meeting(x, yprevious+1, o_solid) {
	im_scale[h] = 1.3
	im_scale[v] = .7
	
}

im_scale[h]	= lerp(im_scale[h],1,.2)
im_scale[v]	= lerp(im_scale[v],1,.2)

if p_health <= 10 {
	instance_destroy()
}

if coyote_atk > 0 {
	coyote_atk--
}

image_speed	= im_speed*game_spd

timers_system()
trail_coor[0,h]	= lerp(trail_coor[0,h],o_player.x,.6)
trail_coor[0,v]	= lerp(trail_coor[0,v],o_player.y,.6)

for (var i = 1; i < 12; ++i) {
	trail_coor[i,h]	= lerp(trail_coor[i,h],trail_coor[i-1,h],.4)
	trail_coor[i,v]	= lerp(trail_coor[i,v],trail_coor[i-1,v],.4)
}

if buffer_atk > 0 {
	buffer_atk--
}

if bol_floor {
	if time_falling > 30 {
		shake			= 5
	}
	time_falling	= 0
} else if spd[v] > spd_max[v]-1 time_falling++
	

/*
if !bol_floor {
	if coyote > 0 {
		coyote--
		if !jumped && key_jump {
			spd[vv]	= -spd_max[vv]/1.3
			jumped	= true
		}
	}
} else {
	w_jumped	= false
	jumped	= false
	coyote	= coyote_max
}

#endregion 

#region Buffer Jump
if key_jump buffer = buffer_max

if buffer > 0 {
	buffer--
	if bol_floor {
		spd[vv]	= -spd_max[vv]/1.3
		buffer = 0
		jumped	= true
	}
}

