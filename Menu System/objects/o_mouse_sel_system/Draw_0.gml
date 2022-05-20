draw_rectangle(area_left,area_top,area_left+area_opts_w,area_top+area_opts_n*area_opts_h-1,true)

for (var i = 0; i < area_opts_n; ++i) {
	var _bol	= area_mouse_voptions(area_left,area_top,area_opts_w,area_opts_h,area_opts_n)
	draw_rectangle(	area_left,
					area_top+(i)*area_opts_h,
					area_left+area_opts_w,
					area_top+(i+1)*area_opts_h-1,
					!(_bol==i))
}

draw_text(10,10,area_mouse_voptions(area_left,area_top,area_opts_w,area_opts_h,area_opts_n))