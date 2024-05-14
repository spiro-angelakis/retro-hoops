extends Spatial

onready var pathf = $Path/PathFollow
onready var cam = $Path/PathFollow/Camera
onready var ball = $MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	cam.look_at(ball.global_transform.origin, Vector3.UP)
	pathf.offset += 0.2
