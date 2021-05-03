extends Node

# HOOOPS
var hoop1_prefab = preload("res://scene/prefab/hoop/BallHoop.tscn").duplicate()
var hoop2_prefab = preload("res://scene/prefab/hoop/BallHoop2.tscn").duplicate()
var hoop3_prefab = preload("res://scene/prefab/hoop/BallHoop3.tscn").duplicate()
var hoop4_prefab = preload("res://scene/prefab/hoop/BallHoop4.tscn").duplicate()
var hoop5_prefab = preload("res://scene/prefab/hoop/BallHoop5.tscn").duplicate()

var hoop_prefab = null
var hoop_index = 1
# 1 = backyard
# 2 = SPRVLLN
# 3 = Retro Hoops
# 4 = Mirror
# 5 = Window

# BALLLES
var ball1_prefab = preload("res://scene/prefab/balls/Basketball.tscn").duplicate()
var ball2_prefab = preload("res://scene/prefab/balls/Stoneball.tscn").duplicate()
var ball3_prefab = preload("res://scene/prefab/balls/Obbyball.tscn").duplicate()
var ball4_prefab = preload("res://scene/prefab/balls/Glassball.tscn").duplicate()
var ball5_prefab = preload("res://scene/prefab/balls/Slimeball.tscn").duplicate()
var ball6_prefab = preload("res://scene/prefab/balls/Hammer.tscn").duplicate()
var ball7_prefab = preload("res://scene/prefab/balls/Fish.tscn").duplicate()
var ball8_prefab = preload("res://scene/prefab/balls/Knife.tscn").duplicate()

var ball_prefab = null
var ball_index = 1
# 1 = original
# 2 = stoneball
# 3 = obbyball
# 4 = glassball
# 5 = slimeball
# 6 = hammer
# 7 = fish
# 8 = knife



# CAGES
var cage1_prefab = preload("res://scene/prefab/cage/Cage1.tscn").duplicate()
var cage2_prefab = preload("res://scene/prefab/cage/Cage2.tscn").duplicate()
var cage3_prefab = preload("res://scene/prefab/cage/Cage3.tscn").duplicate()
var cage4_prefab = preload("res://scene/prefab/cage/Cage4.tscn").duplicate()
var cage5_prefab = preload("res://scene/prefab/cage/Cage5.tscn").duplicate()
var cage6_prefab = preload("res://scene/prefab/cage/Cage6.tscn").duplicate()
var cage7_prefab = preload("res://scene/prefab/cage/Cage7.tscn").duplicate()
var cage8_prefab = preload("res://scene/prefab/cage/Cage8.tscn").duplicate()
var cage9_prefab = preload("res://scene/prefab/cage/Cage9.tscn").duplicate()

var cage_prefab = null
var cage_index = 1


var current_game_parent = null

var game_data = {
	"points" : 0,
	"level" : 1,
	"balls left" : 8,
	"balls total" : 8,
	"tickets" : 0,
	"all-time points" : 0
}

var shots_missed = 0
var win_streak = 0
var current_streak = 0

var game_time_sec = 0
var game_time_min = 0
var game_time_hour = 0

var game_time_mod = 1

var playing_game = false

var hoop_focus = null
var hoop_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_prefab = ball1_prefab
	hoop_prefab = hoop1_prefab
	cage_prefab = cage1_prefab


func _process(delta):
	if playing_game:
		if current_streak >= 3:
			current_streak = 0
			game_data.level += 1
		
		if game_data.level > 1 and shots_missed >= 5:
			game_data.level -= 1
			shots_missed = 0


func change_ball(upbool):
	if upbool:
		ball_index += 1
		if ball_index == 9:
			ball_index = 1
	else:
		ball_index -= 1
		if ball_index == 0:
			ball_index = 9
	
	if ball_index == 1:
		ball_prefab = ball1_prefab
	elif ball_index == 2:
		ball_prefab = ball2_prefab
	elif ball_index == 3:
		ball_prefab = ball3_prefab
	elif ball_index == 4:
		ball_prefab = ball4_prefab
	elif ball_index == 5:
		ball_prefab = ball5_prefab
	elif ball_index == 6:
		ball_prefab = ball6_prefab
	elif ball_index == 7:
		ball_prefab = ball7_prefab
	elif ball_index == 8:
		ball_prefab = ball8_prefab



func change_cage(upbool):
	if upbool:
		cage_index += 1
		if cage_index == 10:
			cage_index = 1
	else:
		cage_index -= 1
		if cage_index == 0:
			cage_index = 10
	
	if cage_index == 1:
		cage_prefab = cage1_prefab
	elif cage_index == 2:
		cage_prefab = cage2_prefab
	elif cage_index == 3:
		cage_prefab = cage3_prefab
	elif cage_index == 4:
		cage_prefab = cage4_prefab
	elif cage_index == 5:
		cage_prefab = cage5_prefab
	elif cage_index == 6:
		cage_prefab = cage6_prefab
	elif cage_index == 7:
		cage_prefab = cage7_prefab
	elif cage_index == 8:
		cage_prefab = cage8_prefab
	elif cage_index == 9:
		cage_prefab = cage8_prefab
	
	get_tree().call_group("game", "swap_cage")

func change_hoop(upbool):
	if upbool:
		hoop_index += 1
		if hoop_index == 6:
			hoop_index = 1
	else:
		hoop_index -= 1
		if hoop_index == 0:
			hoop_index = 5
	
	if hoop_index == 1:
		hoop_prefab = hoop1_prefab
	elif hoop_index == 2:
		hoop_prefab = hoop2_prefab
	elif hoop_index == 3:
		hoop_prefab = hoop3_prefab
	elif hoop_index == 4:
		hoop_prefab = hoop4_prefab
	elif hoop_index == 5:
		hoop_prefab = hoop5_prefab
	
	get_tree().call_group("game", "swap_hoop")

