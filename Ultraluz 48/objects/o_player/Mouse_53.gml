var _hor	= (mouse_x > x)*2 - 1
var _bullet			= instance_create_depth(x-32*_hor,y-8,depth,o_bullet)
var _dir	= point_direction(x,y-12,mouse_x,mouse_y)
_bullet.direction		= _dir
_bullet.image_xscale	= _hor 
