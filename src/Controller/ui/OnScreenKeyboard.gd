extends CanvasLayer

func set_on_screen_input_vector(vec):
	$InputX.text = "x: " + str(snapped(vec.x, 0.1))
	$InputY.text = "y: " + str(snapped(vec.y, 0.1))

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		$Keys/Up.frame = 1
	elif Input.is_action_just_released("ui_up"):
		$Keys/Up.frame = 0
	
	if Input.is_action_just_pressed("ui_down"):
		$Keys/Down.frame = 1
	elif Input.is_action_just_released("ui_down"):
		$Keys/Down.frame = 0
	
	if Input.is_action_just_pressed("ui_left"):
		$Keys/Left.frame = 1
	elif Input.is_action_just_released("ui_left"):
		$Keys/Left.frame = 0
	
	if Input.is_action_just_pressed("ui_right"):
		$Keys/Right.frame = 1
	elif Input.is_action_just_released("ui_right"):
		$Keys/Right.frame = 0


func _on_back_pressed():
	get_tree().change_scene_to_file("res://src/MainScrene/main_scene.tscn")
