extends Spatial

var current_level = 1


var path1_prefab = load("res://scene/prefab/path/HoopPath8.tscn")

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
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("game")
	GameBrain.playing_game = true
	GameBrain.current_game_parent = self
	GameBrain.hoop_focus = $HoopFocus
	prepare()

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
		hoop = GameBrain.hoop_prefab.instance()
		add_child(hoop)
	
	can_go = true



func swap_cage():
	if cage != null:
		remove_child(cage)
	cage = GameBrain.cage_prefab.instance()
	add_child(cage)

func swap_room():
	if room != null:
		remove_child(room)
	room = GameBrain.room_prefab.instance()
	add_child(room)

func swap_hoop():
	if hoop != null:
		remove_child(hoop)
		hoop = null
	if pathf != null:
		remove_child(pathf)
		pathf = null
	hoop = GameBrain.hoop_prefab.instance()
	add_child(hoop)
	moving = false

func add_pathf():
	var ppathf = path1_prefab.instance()
	add_child(ppathf)
	pathf = ppathf

func difficulty_lower():
	
	if moving:
		remove_child(pathf)
		pathf = null
		moving = false
		hoop = GameBrain.hoop_prefab.instance()
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
		ball = GameBrain.ball_prefab.instance()
		add_child(ball)
		var pos = Vector3(pos3d.x, pos3d.y, $Shooter.global_transform.origin.z)
		ball.global_transform.origin = $Shooter.global_transform.origin
		ball.mode = RigidBody.MODE_KINEMATIC
		
		holding_ball = true

func move_ball(pos2d):
	ball.global_transform.origin = Vector3(pos2d.x, pos2d.y, $Shooter.global_transform.origin.z)

func shoot_ball(xdir, ydir):
	holding_ball = false
	ball.mode = RigidBody.MODE_RIGID
	var randx = rand_range(-1.2,1.2) * GameBrain.game_data["aim skill"]
	ball.apply_impulse(ball.global_transform.origin, Vector3( randx + xdir, rand_range(1,2) + (ydir * 0.2), rand_range(-4,-8) + -(ydir * 0.15)))



func still_streak():
	$HornSound.stop()
	$HornSound.play()
	$StreakTimer.start(3)
	var tickets_won = round(rand_range(1,2)) * (GameBrain.win_streak * round(rand_range(1,2)))
	$TicketParticles.amount = tickets_won
	$TicketParticles.emitting = true
	GameBrain.game_data["tickets"] += tickets_won

func _on_StreakTimer_timeout():
	GameBrain.current_streak = 0
	GameBrain.win_streak = 0