extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 600
var check_inattack_zone = false

var can_takedamage = true


var ldboard_name = "main"
var metadata = {
   "elapsed_time_ms": str(Global.m)+":"+str(Global.s)+":"+str(Global.ms),
}
var skill_damage = false
func _process(delta):
	deal_damage()
	update_health()
	
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("default")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else :
			$AnimatedSprite2D.flip_h = false
	else :
		$AnimatedSprite2D.play("idle_front")

func _on_detection_body_entered(body):
	player = body
	player_chase = true


func _on_detection_body_exited(body):
	player = null
	player_chase = false

func skeleton():
	pass
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		check_inattack_zone = true
	if body.has_method("flame"):
		check_inattack_zone = true
		$hurt.play()
		$take_damage_cooldown.start()
		can_takedamage = false
		Global.mana -= 60
		health = health - 300
		print("Vampire health ", health)



func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		check_inattack_zone = false


func deal_damage():
	if check_inattack_zone and Global.player_current_attack == true:
		if can_takedamage == true:
			$hurt.play()
			health = health - 20
			$take_damage_cooldown.start()
			can_takedamage = false
			print("Vampire health ", health)
			if health <=0:
				SilentWolf.Scores.save_score(Global.username, Global.score, ldboard_name, metadata)
				Global.username = ""
				Global.player_current_attack = false
				get_tree().change_scene_to_file("res://src/CreditScene/CreditScene.tscn")

func update_health():
	var healthbar = $healthbar
	healthbar.value = health

func _on_take_damage_cooldown_timeout():
	skill_damage = false
	can_takedamage = true


func _on_story_body_entered(body):
	if body.has_method("player"):
		if Global.isStory4Finished == false:
			if health >= 1:
				DialogueManager.show_example_dialogue_balloon(load("res://story/story4.dialogue"), "s4")
				Global.isStory4Finished = true
				pass
