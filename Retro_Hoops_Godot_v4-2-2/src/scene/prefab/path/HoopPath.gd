extends Path3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var pathf = $PathFollow


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("hooppath")
	var hoop = GameBrain.hoop_prefab.instantiate()
	pathf.add_child(hoop)

func _process(delta):
	pathf.progress += GameBrain.hoop_speed