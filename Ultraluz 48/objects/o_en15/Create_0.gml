randomize()

#region Iniciar variables

//Velocidad en x y
spd			= [0,0]
spd_push	= [0,0]

//Velocidad máxima en x
//Velocidad máxima en y
spd_max			= [.3,.3]

//Aceleración en x
//Aceleración en y
spd_acc			= [.1,.5]

//Velocidad de imagen
//Escalado de imagen
//Rotación de imagen
im_speed	= 1
im_scale	= [1,1]
im_dir			= 0

//Velocidades de dirección
spd_dir_aux	= 0
spd_dir		= 0

//Distancia de colisión
dis_col		= 48

//Recibe daño
bol_hit		= false

//Detecta al jugador
bol_player	= false

#endregion

enum bat_st {
	fly,
	fly_atk,
	death
}

#region	Estados
st_ev[bat_st.fly] = function() {
	event_animation(s_en_02,1)
	
	spd_dir_aux++
	spd_dir	= dsin(spd_dir_aux)*random_range(.2,1)

	im_dir	= (im_dir + 360 + spd_dir) % 360

	/*
	spd_i	= lerp(spd_i,3*(image_index >= 3 && image_index <= 5),.03)
	x += lengthdir_x(spd_i,im_dir)
	y += lengthdir_y(spd_i,im_dir)
	*/
	spd[h]	= lengthdir_x(1,im_dir)
	spd[v]	= lengthdir_y(1,im_dir)

	if place_meeting(x+lengthdir_x(dis_col,im_dir),y+lengthdir_y(dis_col,im_dir),o_solid) ||
		place_meeting(x+lengthdir_x(dis_col,im_dir),y+lengthdir_y(dis_col,im_dir),o_en15) {
		im_dir += 2
	}

	if (im_dir + 90 + spd_dir) % 360 < 180 {
		image_xscale	= 1
	} else {
		image_xscale	= -1 
	}

	if event_damage() {}

}

//Variables de estados
state	= bat_st.fly
#endregion

timer_amount = 3

for (var i = 0; i < timer_amount; ++i) {
	timer[i]		= -1
	timer_ev		= function() {}
}
