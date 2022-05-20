#macro SHIELD_ABS_TIME	40
#macro ATK_ABS_COOLDOWN	60

//Velocidad en x y
spd			= [0,0]
spd_push	= [0,0]

//Velocidad máxima al correr
//Velocidad máxima al caer
spd_max			= [.3,8]

//Aceleración
//Gravedad
spd_acc			= [1,.5]

shield			= noone
atk_dash		= 3

shield_time		= 0

enum en_st {
	idle,
	walk,
	shield,
	preatk,
	atk,
	damage
}

en_state	= en_st.idle

hdir		= -1


