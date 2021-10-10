extends Node2D

onready var throwline = $ThrowLine

var touching = false
var holding_ball = false
var currentForce = Vector2(0,0)

onready var scoretext = $HUD/HBoxContainer/CenterContainer/VBoxContainer/ScoreText
onready var leveltext = $HUD/HBoxContainer/CenterContainer2/VBoxContainer/LevelText
onready var timetext = $HUD/HBoxContainer/CenterContainer2/VBoxContainer/TimeText
onready var ballstext = $HUD/HBoxContainer/CenterContainer/VBoxContainer/BallsText
onready var tickettext = $HUD/HBoxContainer/CenterContainer3/VBoxContainer/TicketText

onready var adbribetext = $AdProposal/VBoxContainer/AmountText

var points = 0
var level = 1
var balls = 8
var tickets = 0
var tickets_since_ad = 0

var shopping = false
var proposing_ad = false

onready var ad_proposal = $AdProposal

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AdTimer.start(5)
	ad_proposal.visible = false
	add_to_group("gameui")
	get_tree().call_group("sandman", "time_began")
	var ss = OS.get_screen_size(-1)
	$ViewportContainer.rect_min_size = ss
	$ViewportContainer.rect_size = ss
	$ViewportContainer/Viewport.size = ss
	$TouchScreenButton.shape.extents = ss
	$NoticeStart.rect_min_size = ss
	$NoticeStart.rect_size = ss
	$Shop.rect_min_size = ss
	$Shop.rect_size = ss
	$AdProposal.rect_min_size = ss
	$AdProposal.rect_size = ss
	$QuitQuery.rect_min_size = ss
	$QuitQuery.rect_size = ss
	

func propose_reward():
	Data.save()
	var bribe = round(rand_range(50,100)) * GameBrain.game_data["level"]
	GameBrain.current_bribe_amount = bribe
	adbribetext.bbcode_text = str("[center]" + str(bribe) + " tickets[/center]")
	ad_proposal.visible = true
	proposing_ad = true

func _physics_process(delta):
	check_tickets()
	
	update_hud()
	
	if proposing_ad and holding_ball:
		holding_ball = false
		throwline.set_point_position(0, Vector2(0,0))
		throwline.set_point_position(1, Vector2(0,0))
	
	if holding_ball:
		throwline.set_point_position(1, get_global_mouse_position())
		currentForce = throwline.get_point_position(0) - throwline.get_point_position(1)
		currentForce = -currentForce
		#get_tree().call_group("game", "move_ball", get_global_mouse_position())

func check_tickets():
	if tickets_since_ad >= 50:
		# we unlocked a new item ! WIP
		tickets_since_ad = 0
		$AdGuy.roll_passive_ad()

func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Data.save()
		$QuitQuery.visible = true

func update_hud():
	points = GameBrain.game_data["points"]
	level = GameBrain.game_data["level"]
	balls = GameBrain.game_data["balls left"]
	if tickets != GameBrain.game_data["tickets"]:
		tickets_since_ad += GameBrain.game_data["tickets"] - tickets
	tickets = GameBrain.game_data["tickets"]
	
	scoretext.bbcode_text = str("[center]Score: " + str(points) + "[/center]")
	leveltext.bbcode_text = str("[center]Level: " + str(level) + "[/center]")
	timetext.bbcode_text = str("[center]Sesh: " + str(GameBrain.game_time_min) + " : " + str(GameBrain.game_time_sec) + "[/center]")
	ballstext.bbcode_text = str("[center]Balls: " + str(balls) + "[/center]")
	tickettext.bbcode_text = str("[center]Tickets: " + str(tickets) + "[/center]")

func done_shopping():
	shopping = false
	Data.save()


func _on_TouchScreenButton_pressed():
	touching = true
	if !shopping and !proposing_ad and !holding_ball and GameBrain.game_data["balls left"] > 0:
		holding_ball = true
		throwline.set_point_position(0, get_global_mouse_position())
		var pos3d = Vector3(clamp(0 - get_global_mouse_position().x, -1.5, 1.5), clamp(0 - get_global_mouse_position().y, -1.5, 1.5), 0)
		get_tree().call_group("game", "hold_ball", pos3d)


func _on_TouchScreenButton_released():
	touching = false
	throwline.set_point_position(0, Vector2(0,0))
	throwline.set_point_position(1, Vector2(0,0))
	if !shopping and !proposing_ad:
		
		if holding_ball:
			holding_ball = false
			get_tree().call_group("game", "shoot_ball", float(currentForce.x * 0.2), -float(currentForce.y * 0.2))


func _on_AdTimer_timeout():
	#$AdMob.show_banner()
	#$AdTimer.start(round(rand_range(10, 20)))
	pass


func _on_ShopButton_pressed():
	Data.save()
	if !proposing_ad:
		$ClickSound.play()
		$Shop.visible = true
		shopping = true



func _on_NoticeStartTimer_timeout():
	$NoticeStart.queue_free()


func _on_AdAcceptButton_pressed():
	Data.save()
	if proposing_ad:
		$ClickSound.play()
		$AdGuy.go_reward()
		$AdProposal.visible = false
		proposing_ad = false


func _on_AdDeclineButton_pressed():
	Data.save()
	if proposing_ad:
		$ClickSound.play()
		$AdProposal.visible = false
		proposing_ad = false
		var chance_to_ad = round(rand_range(0,2))
		if chance_to_ad == 2:
			$AdGuy.roll_passive_ad()
	


func _on_KeepPlayingButton_pressed():
	Data.save()
	if $QuitQuery.visible:
		$ClickSound.play()
		$QuitQuery.visible = false


func _on_QuitGameButton_pressed():
	Data.save()
	if $QuitQuery.visible:
		$ClickSound.play()
		get_tree().quit()
