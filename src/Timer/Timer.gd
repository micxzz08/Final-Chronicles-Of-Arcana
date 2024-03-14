extends RichTextLabel

func _ready():
	$Timer.start()
	pass 



func _process(delta):
	if Global.current_scene != "world_scene" and Global.current_scene != "settings_scene":
		if Global.ms > 9:
			Global.s += 1
			Global.ms = 0
	
		if Global.s > 59:
			Global.m += 1
			Global.s = 0
			
		set_text(str(Global.m)+":"+str(Global.s)+":"+str(Global.ms))
	else: 
		pass
		



func _on_timer_timeout():
	if Global.current_scene != "world_scene" and Global.current_scene != "settings_scene":
		Global.score -= 1
		Global.ms += 1
	else:
		pass #
