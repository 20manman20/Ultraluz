image_xscale	= lerp(image_xscale,0,.1)
image_yscale	= lerp(image_yscale,0,.1)

if image_xscale < .1 instance_destroy()

speed	= lerp(speed,0,.6)

image_angle+=3
