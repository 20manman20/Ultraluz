//Inicio macros
#macro	h				0
#macro	v				1
#macro	COL_TIME		10
#macro	HIT_ABS_TIME	30

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


#region Variables de Salto
buffer_max		= 5
buffer			= 0

coyote_max		= 5
coyote			= 0

jumped			= false

#endregion

enum p_st {
	idle,
	run,
	trn_ar,
	jump,
	jmp_fll,
	fall,
	wall_hang,
	wall_climb,
	atk_00,
	atk_01,
	dash,
	roll,
	roll_land,
	hit,
	death
}

_input			= 1

buffer_atk_max	= 20
buffer_atk		= 0
p_state			= p_st.idle

hit_time		= 0

dash_spd		= 7

i_scale			= [1,1]
hdir			= 1
