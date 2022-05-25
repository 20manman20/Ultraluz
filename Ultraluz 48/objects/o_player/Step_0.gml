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


bol_floor	= place_meeting(x,y+1,o_solid)

spd_final[h]	= spd[h] + spd_push[h]
spd_final[v]	= spd[v] + spd_push[v]

if game_spd {
	spd_push[h]	= approach(spd_push[h],0,.2)
	spd_push[v]	= approach(spd_push[v],0,.2)
}

if buffer_atk > 0 {
	buffer_atk--
}

st_ev[state]()

if place_meeting(x, y+1, o_solid) && !place_meeting(x, yprevious+1, o_solid) {
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
