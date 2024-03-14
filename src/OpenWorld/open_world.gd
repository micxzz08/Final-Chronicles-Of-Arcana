extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	

func _on_dugeon_enter_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_dugeon_enter_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false


func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "open_world":
			Global.current_scene = "world_scene"
			Global.player_skill = false
			get_tree().change_scene_to_file("res://src/WorldScene/world_scene.tscn")
			Global.finish_changedscene()


func _on_portal_enter_body_entered(body):
	if Global.portal1 == true:
		if body.has_method("player"):
			Global.current_scene = "dungeon_scene"
			Global.player_skill = false
			get_tree().change_scene_to_file("res://src/DungeonScene/dungeon_secene.tscn")
			Global.finish_changedscene()

