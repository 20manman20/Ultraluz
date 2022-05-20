if trans == 1 {
	trans_val_an	= clamp(trans_val_an+3,0,180);
	if trans_val_an	== 180 {
		trans_val_an	= 0;
		trans	= 0;
	}
}

trans_val	= dsin(trans_val_an);

if trans_val == 1 {
	if room_exists(trans_room_to) room_goto(trans_room_to);
	trans_room_to	= noone;
}