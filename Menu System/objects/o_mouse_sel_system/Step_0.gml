area_opts_n	= max(1,area_opts_n+mouse_wheel_down() - mouse_wheel_up())

var _hinput	= (keyboard_check(ord("D")) - keyboard_check(ord("A")))
var _vinput	= (keyboard_check(ord("S")) - keyboard_check(ord("W")))

area_opts_w	= max(2,area_opts_w + _hinput*4)
area_opts_h	= max(2,area_opts_h + _vinput)

