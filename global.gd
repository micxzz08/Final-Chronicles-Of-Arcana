extends Node

var current_scene = "world_scene"#open_world
var transition_scene = false

var player_skill = false
var player_current_attack = false
var isChestOpen = true

var player_exit_dungeon_posx = 583
var player_exit_dungeon_posy = 609
var player_start_posx = 580
var player_start_posy = 315
var score = 600000
var health = 100
var mana = 100
var playerLives = 3
var username = ""

var leaderboards = []
var isStory1Finished = false
var isStory2Finished = false
var isStory3Finished = false
var isStory4Finished = false
var portal1 = false		
var portal2 = false

var ms = 0
var s = 0
var m = 0

var game_first_loading = true

func  _ready():
	SilentWolf.configure({
		"api_key": "TKSqhlONRC3zBQ4WOQgxC6RW0SS0YJr71jfK38cV",
		"game_id": "chroniclesofarcana",
		"log_level": 1
  	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://src/MainScrene/main_scene.tscn"
  	})
	
func finish_changedscene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world_scene":
			current_scene = "open_world"
		elif current_scene == "open_world":
			current_scene = "world_scene"
		elif current_scene == "dungeon_scene":
			current_scene = "world_scene"
		else:
			current_scene = "world_scene"
	
