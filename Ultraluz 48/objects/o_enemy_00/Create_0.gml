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
hdir		= image_xscale
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
	event_gravity()
	event_animation(s_en_00_idle,1)
	spd[h]	= approach(spd[h],0,spd_acc[h])
	

	if event_damage() {
	} else if bol_player && timer[TIMER_ATK] == -1 {
		event_insta_flip(sign(o_player.x-x))
		image_index	= 0
		state	= en_st.preatk
	}
}

st_ev[en_st.walk]		= function() {
	event_gravity()
	event_animation(s_en_00_walk,1)
	spd[h]	= approach(spd[h],spd_max[h]*hdir_d,spd_acc[h])
	
	if !place_meeting(x+8*hdir_d,y+1,o_solid) event_insta_flip(hdir*(-1))
	
	if event_damage() {
	} else if bol_player && timer[TIMER_ATK] == -1 {
		event_insta_flip(sign(o_player.x-x))
		image_index	= 0
		state	= en_st.preatk
	}
}

st_ev[en_st.preatk]		= function() {
	event_gravity()
	event_animation(s_en_00_atk,1)
	spd[h]	= approach(spd[h],0,spd_acc[h])
	hdir	= sign(o_player.x-x)
	
	if event_damage() {
	} else if image_index >= image_number - 3 {
		timer[TIMER_ATK]			= ATK_ABS_COOLDOWN
		var _atk			= instance_create_depth(x*hdir_d,y,depth,o_en_00_atk)
		_atk.image_xscale	= hdir_d
		_atk.en_id			= id
		state	= en_st.atk
	}
}

st_ev[en_st.atk]		= function() {
	event_gravity()
	event_animation(s_en_00_atk,1)
	
	if event_damage() {
	} else if animation_end() {
		if sign(o_player.x - x) == hdir {
			state	= en_st.preatk_1
			sprite_index	= s_en_00_atk_1
			image_index	= 0
		} else {
			state	= en_st.idle
			timer[TIMER_ATK]	= ATK_ABS_COOLDOWN
		}
	}
}

st_ev[en_st.preatk_1]		= function() {
	event_gravity()
	event_animation(s_en_00_atk_1,1)
	spd[h]	= approach(spd[h],0,spd_acc[h])
	
	if image_index >= 2 && sign(x-o_player.x) == hdir_d {
		state	= en_st.idle
		timer[TIMER_ATK]	= ATK_ABS_COOLDOWN
	}
	
	
	if event_damage() {
	} else if image_index >= image_number - 4 && sign(x-o_player.x) == -hdir_d {
		var _dis			= max(0,abs(x-o_player.x)-48)
		spd_push[0]			= clamp(hdir*(power(1+8*_dis,.5)-1)/2,-12,12)
		if image_index >= image_number - 3 {
			timer[TIMER_ATK]			= ATK_ABS_COOLDOWN
			var _atk			= instance_create_depth(x*hdir_d,y,depth,o_en_00_atk)
			_atk.image_xscale	= hdir_d
			_atk.en_id			= id
			state	= en_st.atk_1
		}
	} 
}

st_ev[en_st.atk_1]		= function() {
	event_gravity()
	event_animation(s_en_00_atk_1,1)
	event_damage()
	if animation_end() {
		state	= en_st.idle
	}
}

st_ev[en_st.shield]		= function() {
	event_animation(s_en_00_shield,1)
	event_gravity()
	spd[h]	= 0
	
	shield_time--
		
	if shield_time <= 0 {
		shield_time	= 0
		im_speed	= 1
		state	= en_st.idle
			
	}
		
	if animation_end() im_speed	= 0
	if !bol_player	{
		state	= en_st.idle
		timer[tm_change_idle_walk] = irandom_range(60,90)
	} else hdir	= sign(bol_player.x-x)
}

st_ev[en_st.death]		= function() {
	event_gravity()
	event_animation(s_en_00_death,1)
	spd[h]	= 0
	if animation_end() instance_destroy()
}

//Variables de estados
state	= en_st.idle

#endregion

#region Timers
tm_change_dir		= 2
tm_change_idle_walk	= 3

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
			timer[tm_change_dir] += timer[tm_change_idle_walk]
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
timer[tm_change_dir]	= irandom_range(30,60)
timer[tm_change_idle_walk]	= irandom_range(60,90)

det_front	= 120
det_behind	= 50 
