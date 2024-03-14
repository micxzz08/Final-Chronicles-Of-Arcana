extends Node2D

func _ready():
	if Global.game_first_loading == true:
		$CharacterBody2D.position.x = Global.player_start_posx
		$CharacterBody2D.position.y = Global.player_start_posy
	else:
		$CharacterBody2D.position.x = Global.player_exit_dungeon_posx
		$CharacterBody2D.position.y = Global.player_exit_dungeon_posy

func _process(delta):
	change_scene()


func _on_dungeon_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		
func _on_dungeon_exit_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world_scene":
			Global.current_scene = "open_world"
			Global.player_skill = false
			get_tree().change_scene_to_file("res://src/OpenWorld/open_world.tscn")
			Global.game_first_loading = false
			Global.finish_changedscene()
		
func _on_story_area_entered(area):
	if Global.isStory1Finished == false:
		DialogueManager.show_example_dialogue_balloon(load("res://story/story1.dialogue"), "s1")
		Global.isStory1Finished = true
		pass 
