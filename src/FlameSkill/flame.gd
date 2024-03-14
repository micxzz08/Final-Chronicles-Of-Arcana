extends CharacterBody2D

var velo = Vector2(0, 1)
var speed = 300

func _physics_process(delta):
	var collision_info = move_and_collide(velo.normalized() * delta * speed)

func flame():
	pass

func _on_area_2d_body_entered(body):
	$Timer.start()
	if body.has_method("enemy") or body.has_method("skeleton") or body.has_method("boss"): 
		Global.player_current_attack = true
		queue_free()

func _on_timer_timeout():
	$Timer.stop()
	Global.player_current_attack = false
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
