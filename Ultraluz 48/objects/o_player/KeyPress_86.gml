var _limit	= 32
for (var i = 0; i < 64; ++i) {
	if collision_point(x,y-i*4-32,o_solid,false,true) {
		_limit	= i*4
		break
	}
}

grapple			= [x,y-_limit-32]
rope			= [x,y]
rope_angle		= point_direction(grapple[h],grapple[v],x,y)
rope_length		= point_distance(grapple[h],grapple[v],x,y)
rope_angle_spd = spd[h]
state			= p_st.swing
