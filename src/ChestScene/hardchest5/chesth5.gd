extends CharacterBody2D


func chesth5():
	pass

var potion = preload("res://src/PotionFallingScene/potion.tscn")



func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.play()

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		queue_free()


