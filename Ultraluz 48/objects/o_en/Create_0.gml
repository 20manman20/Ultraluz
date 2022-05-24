init_x	= x
init_y	= y

go_x	= o_player.x
go_y	= o_player.y-16

state	= 0

hdir	= sign(o_player.x-x)

function cuadratic(_val, _x,_y,_h,_k) {
	var _p	= power(_x-_h,2)/(4*(_y-_k))
	
	var _a, _b, _c
	_a	= 1/(4*_p)
	_b	= -(2*_h/(4*_p))
	_c	= power(_h,2)/(4*_p)+_k
	
	return (power(_val,2)*_a)+_val*_b+_c
}


