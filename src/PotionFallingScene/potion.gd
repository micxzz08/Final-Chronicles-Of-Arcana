extends Area2D


func _ready():
	fallfromchest()

func fallfromchest():
	$AnimationPlayer.play("potion_fall")
	await get_tree().create_timer(2).timeout
	$AnimationPlayer.play("potion_collected")
	await get_tree().create_timer(0.3).timeout
	queue_free()
