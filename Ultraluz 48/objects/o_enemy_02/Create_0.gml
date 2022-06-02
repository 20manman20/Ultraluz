#region Iniciar variables

//Velocidad en x y
spd			= [0,0]
spd_push	= [0,0]

//Velocidad máxima al correr
//Velocidad máxima al caer
spd_max			= [.3,8]

//Aceleración
//Gravedad
spd_acc			= [.1,.5]

//Dash por default al atacar
atk_dash		= 3

//Dirección a la que mira
//Dirección a la que va a apuntar
//Direccion mientras volta
//Dirección que dibuja
hdir		= 1
hdir_r		= hdir
hdir_d		= hdir_r

//Velocidad de imagen
//Escalado de imagen
im_speed	= 1
im_scale		= [1,1]

//Recibe daño
bol_hit		= false

//Detecta al jugador
bol_player	= false

//Magnitud para la lentitud al voltear (1,0)
reaction_time	= 0

//Tiempo del escudo
shield_time		= 0

#endregion

#region	Estados
st_ev[en_st.idle]		= function() {
	event_animation(s_en_02,1)
	spd[h]	= approach(spd[h],0,spd_acc[h])
	
}

st_ev[en_st.walk]		= function() {
	event_animation(s_en_02,1)
	spd[h]	= approach(spd[h],spd_max[h]*hdir_d,spd_acc[h])
}

st_ev[en_st.preatk]		= function() {
}

//Variables de estados
state	= en_st.idle

#endregion

#region Timers
tm_change_dir		= 0
tm_change_idle_walk	= 1

timer_ev[tm_change_dir] = function() {
	switch (state) {
	    case en_st.idle:
			//Cambiar de dirección
			//Cuánto quieres que dure en esa dirección
			event_insta_flip(hdir*(-1))
			break;
	}
	timer[tm_change_dir] = irandom_range(30,60)
}

timer_ev[tm_change_idle_walk] = function() {
	switch (state) {
	    case en_st.idle:
			//Cambia a caminar
			//Cuánto quieres que dure caminando
			state	= en_st.walk
			timer[tm_change_idle_walk] = irandom_range(180,240)
			timer[tm_change_idle_walk] += timer[tm_change_idle_walk]
			break;
	    case en_st.walk:
			//Cambia a quieto
			//Cuánto quieres que dure quieto
	        state	= en_st.idle
			timer[tm_change_idle_walk] = irandom_range(60,90)
	        break;
	}
}

timer_ev[TIMER_DMG]	= function() {}
timer_ev[TIMER_ATK]	= function() {}

//Variables y funcionamiento de timers
timer_amount	= 4

for (var i = 0; i < timer_amount; ++i) {
	timer[i]		= -1
}

#endregion

//Iniciar timers aparte
timer[0]	= irandom_range(30,60)
timer[1]	= irandom_range(60,90)

det_front	= 120
det_behind	= 50 
