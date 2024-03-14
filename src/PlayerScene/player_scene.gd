extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_isalive = true

var attack_inpr = false

const run_speed = 300
const walk_speed = 150
const accel = 70
const friction = 400



var input : Vector2 = Vector2.ZERO

var chest_e1 = false
var chest_e2 = false
var chest_e3 = false
var chest_e4 = false

var chest_h1 = false
var chest_h2 = false
var chest_h3 = false
var chest_h4 = false
var chest_h5 = false
var chest_h6 = false

var potion = preload("res://src/PotionFallingScene/potion.tscn")
var fireSkill = preload("res://src/FlameSkill/flame.tscn")
var ultSkill = preload("res://src/UltimateSkill/flame.tscn")

@onready var animation_tree: AnimationTree = $AnimationTree

func drop_potion():
	var potion_instance = potion.instantiate()
	potion_instance.global_position = $Marker2D.global_position
	get_parent().add_child(potion_instance)

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parameters()
	if Global.current_scene == "settings_scene":
		$healthbar.visible = false
		$manabar.visible = false



func _physics_process(delta):
	player_movement(delta)
	current_camera()
	enemy_attack()
	update_player_bar()
	
	if Global.health <= 0:
		if Global.playerLives <= 1:
			player_isalive = false
			print("You have been killed")
			$AnimationPlayer.play("Down")
			self.queue_free()
			Global.username = ""
			Global.player_current_attack = false
			get_tree().change_scene_to_file("res://src/MainScrene/main_scene.tscn")
		else:
			Global.playerLives = Global.playerLives - 1
			print(str(Global.playerLives) + " lives")
			Global.health = 100

	if chest_e1 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/easyquestion_1.dialogue"), "eq1")
				drop_potion()
				Global.health += 30
				Global.mana += 30
				return
	
	if chest_e2 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/easyquestion_2.dialogue"), "eq2")
				drop_potion()
				Global.health += 30
				Global.mana += 30
				return
	
	if chest_e3 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/easyquestion_3.dialogue"), "eq3")
				drop_potion()
				Global.health += 30
				Global.mana += 30
				return
	
	if chest_e4 == true:	
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/easyquestion_4.dialogue"), "eq4")
				drop_potion()
				Global.health += 30
				Global.mana += 30
				return
	
	if chest_h1 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_1.dialogue"), "hq1")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return
	
	if chest_h2 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_2.dialogue"), "hq2")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return
	
	if chest_h3 == true:
		if Input.is_action_just_pressed("ui_accept"):
			if Global.isChestOpen == true:
				pass
			if Global.isChestOpen == false:
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_3.dialogue"), "hq3")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return
	
	if chest_h4 == true:
		if Global.isChestOpen == true:
				pass
		if Global.isChestOpen == false:
			if Input.is_action_just_pressed("ui_accept"):
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_4.dialogue"), "hq4")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return
	
	if chest_h5 == true:
		if Global.isChestOpen == true:
				pass
		if Global.isChestOpen == false:
			if Input.is_action_just_pressed("ui_accept"):
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_5.dialogue"), "hq5")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return
	
	if chest_h6 == true:
		if Global.isChestOpen == true:
				pass
		if Global.isChestOpen == false:
			if Input.is_action_just_pressed("ui_accept"):
				Global.isChestOpen = true
				DialogueManager.show_example_dialogue_balloon(load("res://questions/hardquestion_6.dialogue"), "hq6")
				drop_potion()
				Global.health += 50
				Global.mana += 50
				return

func get_input():
	input.x = int(Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D)) - int(Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A))
	input.y = int(Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S)) - int(Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W))
	return input.normalized()

func player_movement(delta):
	input = get_input()
			
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() *  (friction * delta)
		else:
			velocity = Vector2.ZERO
	else: 
		velocity += (input * accel * friction)
		if  int(Input.is_action_pressed("run")):
			velocity = velocity.limit_length(run_speed)
		else:
			velocity = velocity.limit_length(walk_speed)
	
	move_and_slide()
		

func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if(Input.is_action_just_pressed("attack")):
		animation_tree["parameters/conditions/attack"] = true
		$sword_slash.play();
		Global.player_current_attack = true
		$deal_attack_timer.start()
		attack_inpr = true
	else:
		animation_tree["parameters/conditions/attack"] = false
		
	if(Input.is_action_just_pressed("skill")):
		if Global.player_skill == false:
			if Global.current_scene != "world_scene":
				if Global.mana >= 10:
					$Node2D.look_at(get_global_mouse_position())
					shoot()
					Global.player_skill = true
					Global.mana = Global.mana - 20
					attack_inpr = true
	
	
	if(input != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = input
		animation_tree["parameters/Attack/blend_position"] = input
		animation_tree["parameters/Walk/blend_position"] = input

func player():
	pass
	
func current_camera():
	if Global.current_scene == "world_scene":
		$Camera2D.enabled = true
	elif Global.current_scene == "open_world":
		$Camera2D.enabled = false
		$Camera2D3.enabled = false
		if	$Camera2D.enabled == false and $Camera2D3.enabled == false:
			$Camera2D2.enabled = true
	elif Global.current_scene == "dungeon_scene":
		$Camera2D.enabled = false
		$Camera2D2.enabled = false
		if	$Camera2D.enabled == false and $Camera2D2.enabled == false:
			$Camera2D3.enabled = true
	elif Global.current_scene == "boss_scene":
		$Camera2D.enabled = false
		$Camera2D2.enabled = false
		$Camera2D3.enabled = false
		if	$Camera2D.enabled == false and $Camera2D2.enabled == false and $Camera2D3.enabled == false:
			$Camera2D4.enabled = true
func shoot():
	if Global.current_scene == "open_world" || Global.current_scene == "settings_scene"  :
		$deal_attack_timer.start()
		$skill_cooldown.start()
		var fire = fireSkill.instantiate()
		fire.global_position = $Node2D/Marker2D2.global_position
		$fire_skill.play();
		get_parent().add_child(fire)
		fire.velo = get_global_mouse_position() - fire.global_position
	elif Global.current_scene == "dungeon_scene":
		$deal_attack_timer.start()
		$skill_cooldown.start()
		$fire_skill.play();
		var fire = fireSkill.instantiate()
		fire.global_position = $Node2D/Marker2D.global_position
		get_parent().add_child(fire)
		fire.velo = get_global_mouse_position() - fire.global_position
		
		var fire2 = fireSkill.instantiate()
		fire2.global_position = $Node2D/Marker2D2.global_position
		fire2.velo = get_global_mouse_position() - fire2.global_position
		get_parent().add_child(fire2)

		
		var fire3 = fireSkill.instantiate()
		fire3.global_position = $Node2D/Marker2D3.global_position
		fire3.velo = get_global_mouse_position() - fire3.global_position
		get_parent().add_child(fire3)
	
	elif Global.current_scene == "boss_scene":
		$deal_attack_timer.start()
		$skill_cooldown.start()
		$fire_skill.play();
		var ult = ultSkill.instantiate()
		ult.global_position = $Node2D/Marker2D2.global_position
		ult.velo = get_global_mouse_position() - ult.global_position
		get_parent().add_child(ult)
		

	
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy") or body.has_method("skeleton") or body.has_method("boss"):
		enemy_inattack_range = true

	if body.has_method("cheste1"):
		chest_e1 = true

	if body.has_method("cheste2"):
		chest_e2 = true

	if body.has_method("cheste3"):
		chest_e3 = true

	if body.has_method("cheste4"):
		chest_e4 = true

	if body.has_method("chesth1"):
		chest_h1 = true

	if body.has_method("chesth2"):
		chest_h2 = true

	if body.has_method("chesth3"):
		chest_h3 = true

	if body.has_method("chesth4"):
		chest_h4 = true

	if body.has_method("chesth5"):
		chest_h5 = true

	if body.has_method("chesth6"):
		chest_h6 = true




func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy") or body.has_method("skeleton") or body.has_method("boss"):
		enemy_inattack_range = false

	if body.has_method("cheste1"):
		chest_e1 = false
	
	if body.has_method("cheste2"):
		chest_e2 = false

	if body.has_method("cheste3"):
		chest_e3 = false

	if body.has_method("cheste4"):
		chest_e4 = false

	if body.has_method("chesth1"):
		chest_h1 = false

	if body.has_method("chesth2"):
		chest_h2 = false

	if body.has_method("chesth3"):
		chest_h3 = false

	if body.has_method("chesth4"):
		chest_h4 = false

	if body.has_method("chesth5"):
		chest_h5 = false

	if body.has_method("chesth6"):
		chest_h6 = false


func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		$player_hurt.play();
		Global.health = Global.health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(Global.health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_inpr = false

func update_player_bar():
	var healthbar = $healthbar
	var manabar = $manabar
	manabar.value = Global.mana
	healthbar.value = Global.health
	

func _on_regen_timer_timeout():
	if Global.health < 100:
		Global.health = Global.health + 2
		# if player is full health doesnt regen health
		if Global.health > 100:
			Global.health = 100
	# if player is dead doesnt regen health
	if Global.health <= 0:
		Global.health = 0
		
	if Global.mana < 100:
		Global.mana = Global.mana + 2
		# if player is full mana doesnt regen mana
		if Global.mana > 100:
			Global.mana = 100
	# if player is dead doesnt regen mana
	if Global.mana <= 0:
		Global.mana = 0


func _on_area_2d_2_body_entered(body):
	if Global.portal2 == true:
		if body.has_method("player"):
			Global.player_skill = false
			Global.current_scene = "boss_scene"
			get_tree().change_scene_to_file("res://src/BossBattleScene/bossbattleScene.tscn")


func _on_skill_cooldown_timeout():
	Global.player_skill = false

