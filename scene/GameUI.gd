extends Node2D

onready var throwline = $ThrowLine

var touching = false
var holding_ball = false
var currentForce = Vector2(0,0)

onready var scoretext = $HUD/HBoxContainer/CenterContainer/ScoreText
onready var leveltext = $HUD/HBoxContainer/CenterContainer2/VBoxContainer/LevelText
onready var timetext = $HUD/HBoxContainer/CenterContainer2/VBoxContainer/TimeText



# Called when the node enters the scene tree for the first time.
func _ready():
	#$AdTimer.start(5)
	get_tree().call_group("sandman", "time_began")
	var ss = OS.get_screen_size(-1)
	$ViewportContainer.rect_min_size = ss
	$ViewportContainer.rect_size = ss
	$ViewportContainer/Viewport.size = ss
	$TouchScreenButton.shape.extents = ss

func _process(delta):
	if holding_ball:
		throwline.set_point_position(1, get_global_mouse_position())
		currentForce = throwline.get_point_position(0) - throwline.get_point_position(1)
		currentForce = -currentForce
		#get_tree().call_group("game", "move_ball", get_global_mouse_position())
		
	update_hud()
	
	pass

func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Data.save()

func update_hud():
	scoretext.bbcode_text = str("[center]Score: " + str(GameBrain.game_data.get("points")) + "[/center]")
	leveltext.bbcode_text = str("[center]Level: " + str(GameBrain.game_data.get("level")) + "[/center]")
	timetext.bbcode_text = str("[center]Level: " + str(GameBrain.game_time_min) + " : " + str(GameBrain.game_time_sec) + "[/center]")




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
		get_tree().call_group("game", "shoot_ball", float(currentForce.x * 0.2), -float(currentForce.y * 0.2))


func _on_AdTimer_timeout():
	#$AdMob.show_banner()
	#$AdTimer.start(round(rand_range(10, 20)))
	pass
