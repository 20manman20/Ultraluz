en_health-=10
if en_health <= 0 instance_destroy()
instance_destroy(other)

shake			= 10
game_spd		= 0
o_camera.alarm[1]	= 2
spd_push		= [other.image_xscale*3,-3]
instance_create_depth(x,y,depth-2,o_atk)
