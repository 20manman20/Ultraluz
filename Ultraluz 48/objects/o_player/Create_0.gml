/*
jmp_fll
*/


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

enum p_st {
	idle,
	run,
	turn_around,
	dash,
	dash_back,
	jump,
	fall,
	jump_fall,
	roll_throw,
	roll,
	roll_throw_back,
	roll_back,
	wall_hang,
	wall_climb,
	atk_00,
	atk_01,
	atk_02,
	atk_air_00,
	atk_air_01,
	atk_air_02,
	atk_air_02_fall,
	atk_air_02_land,
	hit,
	death,
	swing
}

arr_p_st		= [	"idle",
					"run",
					"turn_around",
					"dash",
					"dash_backdsssssssssssssssss",
					"jump",
					"fall",
					"jump_fall",
					"roll_throw",
					"roll",
					"roll_throw_back",
					"roll_back",
					"wall_hang",
					"wall_climb",
					"atk_00",
					"atk_01",
					"atk_air_02",
					"atk_air_02_fall",
					"atk_air_02_land",
					"hit",
					"death",
					"swing"]

grapple			= [0,0]
rope			= [0,0]
rope_angle		= 0
rope_length		= 0
rope_angle_spd	= 0
rope_acc		= 0.2

hinput			= 1
hinput_prev		= hinput

//Ataques
coyote_atk_max	= 20
coyote_atk		= 0
coyote_atk_i	= 1

buffer_atk_max	= 20
buffer_atk		= 0
buffer_atk_i	= 1

p_state			= p_st.idle

hit_time		= 0

dash_spd		= 7

i_scale			= [1,1]
hdir			= 1
