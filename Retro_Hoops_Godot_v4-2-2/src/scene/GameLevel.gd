extends Node3D

var current_level = 1

@onready var camera_1 = $Camera
@onready var camera_2 = $Camera2
@onready var camera_3 = $Camera3
@onready var camera_4 = $Camera4
@onready var camera_5 = $Camera5
@onready var camera_6 = $Camera6
@onready var camera_7 = $Camera7

var cams = []

var path1_prefab = load("res://src/scene/prefab/path/HoopPath8.tscn")

var holding_ball = false
var ball = null

var pathf = null

var shopping = false

var hoop = null
var cage = null
var room = null

var pathspeed = 0.00
var can_go = false

var moving = false

var balls_left = 8
var balls_total = 8

var current_cam = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("game")
	GameBrain.playing_game = true
	GameBrain.current_game_parent = self
	GameBrain.hoop_focus = $HoopFocus
	prepare()
	
	cams = [
	camera_1,
	camera_2,
	camera_3,
	camera_4,
	camera_5,
	camera_6,
	camera_7
	]
	
	current_cam = camera_1
	current_cam.set_current(true)


func try_change_cam():
	if randi_range(0, 100) == 1:
		change_cam()
	elif randi_range(0, 100) <= 25:
		change_cam(0)

func change_cam(cam_num=null):
	var last_cam = current_cam
	
	if cam_num != null and cam_num < cams.size():
		current_cam = cams[cam_num]
	else:
		current_cam = cams.pick_random()
	
	current_cam.set_current(true)
	last_cam.set_current(false)


func prepare():
	swap_cage()
	swap_hoop()
	swap_room()

func _process(delta):
	balls_total = GameBrain.game_data["balls total"]
	
	if GameBrain.game_data.level > current_level:
		can_go = false
		difficulty_raise()
	
	if GameBrain.game_data.level < current_level:
		can_go = false
		difficulty_lower()

func difficulty_raise():
	
	if !moving:
		remove_child(hoop)
		hoop = null
		moving = true
	else:
		remove_child(pathf)
		pathf = null
		moving = false
	
	current_level += 1
	pathspeed += 0.01
	GameBrain.hoop_speed = pathspeed
	
	
	if moving:
		add_pathf()
	else:
		hoop = GameBrain.hoop_prefab.instantiate()
		add_child(hoop)
	
	can_go = true



func swap_cage():
	if cage != null:
		remove_child(cage)
	cage = GameBrain.cage_prefab.instantiate()
	add_child(cage)

func swap_room():
	if room != null:
		remove_child(room)
	room = GameBrain.room_prefab.instantiate()
	add_child(room)

func swap_hoop():
	if hoop != null:
		remove_child(hoop)
		hoop = null
	if pathf != null:
		remove_child(pathf)
		pathf = null
	hoop = GameBrain.hoop_prefab.instantiate()
	add_child(hoop)
	moving = false

func add_pathf():
	var ppathf = path1_prefab.instantiate()
	add_child(ppathf)
	pathf = ppathf

func difficulty_lower():
	
	if moving:
		remove_child(pathf)
		pathf = null
		moving = false
		hoop = GameBrain.hoop_prefab.instantiate()
		add_child(hoop)
	
	current_level -= 1
	pathspeed -= 0.01
	GameBrain.hoop_speed = pathspeed


func regain_ball():
	if (GameBrain.game_data["balls left"] + 1) <= GameBrain.game_data["balls total"]:
		balls_left += 1
		GameBrain.game_data["balls left"] += 1


func hold_ball(pos3d):
	if  !holding_ball and balls_left > 0:
		balls_left -= 1
		GameBrain.game_data["balls left"] -= 1
		ball = GameBrain.ball_prefab.instantiate()
		add_child(ball)
		
		ball.rotation = Vector3(randf_range(-360,360),randf_range(-360,360),randf_range(-360,360))
		
		var pos = Vector3(pos3d.x, pos3d.y, $Shooter.global_transform.origin.z)
		ball.global_transform.origin = $Shooter.global_transform.origin
		ball.set_freeze_enabled(true)
		
		holding_ball = true

func move_ball(pos2d):
	ball.global_transform.origin = Vector3(pos2d.x, pos2d.y, $Shooter.global_transform.origin.z)

func shoot_ball(xdir, ydir):
	try_change_cam()
	holding_ball = false
	ball.set_freeze_enabled(false)
	var randx = randf_range(-1.2,1.2) * GameBrain.game_data["aim skill"]
	ball.apply_impulse(Vector3( randx + xdir, randf_range(1,2) + (ydir * 0.2), randf_range(-4,-8) + -(ydir * 0.15)), Vector3.ZERO)
	ball.thrown()



func still_streak():
	$HornSound.stop()
	$HornSound.play()
	$StreakTimer.start(3)
	var tickets_won = randi_range(1,5) * (GameBrain.win_streak * randi_range(1,2)) * GameBrain.game_data["level"]
	$TicketParticles.amount = tickets_won
	$TicketParticles.emitting = true
	GameBrain.game_data["tickets"] += tickets_won

func _on_StreakTimer_timeout():
	GameBrain.current_streak = 0
	GameBrain.win_streak = 0
