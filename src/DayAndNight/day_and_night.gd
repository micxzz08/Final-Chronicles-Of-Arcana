extends StaticBody2D

var state = "day"

var change_state = false

var length_of_day = 15
var length_of_night = 8

func _ready():
	if state == "day":
		$ColorRect.color.a = 0
	elif state == "night":	
		$ColorRect.color.a = 189
		
func _on_timer_timeout():
	if state == "day":
		state = "night"
	elif state == "night":
		state = "day"
		
	change_state = true

func _process(delta):
	if change_state == true:
		change_state = false
		if state == "day":
			change_to_day()
		elif state == "night":
			change_to_night()

	
func change_to_day():
	$AnimationPlayer.play("night_to_day")
	$Timer.wait_time = length_of_day
	$Timer.start()
	
func change_to_night():
	$AnimationPlayer.play("day_to_night")
	$Timer.wait_time = length_of_night
	$Timer.start()



