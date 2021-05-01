extends Spatial


var ball_prefab = load("res://scene/prefab/Basketball.tscn").duplicate()

var holding_ball = false
var ball = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("game")

func hold_ball(pos3d):
	if !holding_ball:
		ball = ball_prefab.instance()
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
	ball.apply_impulse(ball.global_transform.origin, Vector3(rand_range(-3,3), rand_range(1,12), rand_range(-8,-16)))