extends Node2D

onready var throwline = $ThrowLine

var touching = false
var holding_ball = false
var currentForce = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if holding_ball:
		throwline.set_point_position(1, get_global_mouse_position())
		currentForce = throwline.get_point_position(0) - throwline.get_point_position(1)
		currentForce = -currentForce
		#get_tree().call_group("game", "move_ball", get_global_mouse_position())

func _on_TouchScreenButton_pressed():
	touching = true
	if !holding_ball:
		holding_ball = true
		throwline.set_point_position(0, get_global_mouse_position())
		var pos3d = Vector3(clamp(0 - get_global_mouse_position().x, -1.5, 1.5), clamp(0 - get_global_mouse_position().y, -1.5, 1.5), 0)
		get_tree().call_group("game", "hold_ball", pos3d)


func _on_TouchScreenButton_released():
	touching = false
	throwline.set_point_position(0, Vector2(0,0))
	throwline.set_point_position(1, Vector2(0,0))
	if holding_ball:
		holding_ball = false
		get_tree().call_group("game", "shoot_ball", currentForce.x, currentForce.y)
