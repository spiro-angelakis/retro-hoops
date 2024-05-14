extends Node2D


var current_second = 0
var current_minute = 0
var current_hour = 0

var waiting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("sandman")
	


func _process(delta):
	if waiting and !get_tree().paused:
		waiting = false
		$Time.start(1 * GameBrain.game_time_mod)


func time_began():
	$Time.start(1)
	current_second = 0
	current_minute = 0
	current_hour = 0

func track_time():
	current_second += 1
	
	if current_second >= 60:
		current_second = 0
		current_minute += 1
		if current_minute >= 60:
			current_minute = 0
			current_hour += 1
	
	GameBrain.game_time_sec = current_second
	GameBrain.game_time_min = current_minute
	GameBrain.game_time_hour = current_hour
	check_progress_change()

func check_progress_change():
	pass

func _on_Time_timeout():
	track_time()
	if get_tree().paused:
		waiting = true
	else:
		$Time.start(1 * GameBrain.game_time_mod)

