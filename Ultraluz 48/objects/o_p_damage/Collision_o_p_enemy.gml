/*
var _list	= ds_list_create()
var _place	= instance_place_list(x,y,o_p_enemy,_list,false)

if _place > 0 {
	for (var i = 0; i < ds_list_size(_list); ++i) {
		if ds_list_find_index(en_list,_list[| i]) == -1 {
			with _list[| i] {
				if alarm[2]	== -1 && en_state	!= en_st.death {
					spd_push		= [2*other.image_xscale,0]
					alarm[2]		= 15
					en_health		-= 10
					
					if en_health <= 0 {
						en_state	= en_st.death
						image_index		= 0
						sprite_index	= s_en_00_death
					}
					ds_list_add(other.en_list,id)
					
				}
			}
			instance_destroy()
		}
	}
}

ds_list_destroy(_list)
