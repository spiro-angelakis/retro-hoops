extends Node

var current_game_parent = null

var game_data = {
	"points" : 0,
	"level" : 1,
	"all-time points" : 0
}

var shots_missed = 0
var win_streak = 0

var game_time_sec = 0
var game_time_min = 0
var game_time_hour = 0

var game_time_mod = 1

var playing_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if playing_game:
		if shots_missed
