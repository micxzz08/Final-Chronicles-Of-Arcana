extends Node2D

var scores = []
var idx = 1

func _ready():
	Global.leaderboards = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_play_btn_pressed():
	if (Global.username):
		Global.current_scene = "world_scene"
		Global.playerLives = 3
		Global.health = 100
		Global.mana = 100
		Global.ms = 0
		Global.s = 0
		Global.m = 0
		Global.isChestOpen = false
		Global.portal1 = false
		Global.portal2 = false
		Global.isStory1Finished = false
		Global.isStory2Finished = false
		Global.isStory3Finished = false
		Global.isStory4Finished = false
		get_tree().change_scene_to_file("res://src/WorldScene/world_scene.tscn")


func _on_controls_pressed():
	Global.current_scene = "settings_scene"
	get_tree().change_scene_to_file("res://src/Controller/ui/OnScreenKeyboard.tscn")

func _on_line_edit_text_changed(new_text):
	Global.username = new_text


func _on_leaderboards_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")
