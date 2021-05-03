extends CenterContainer


onready var ballnametext = $VBoxContainer/BallType/ValueContainer/BallNameText
onready var hoopnametext = $VBoxContainer/HoopType/ValueContainer/HoopNameText
onready var cagenametext = $VBoxContainer/CageType/ValueContainer/CageNameText
onready var roomnametext = $VBoxContainer/RoomType/ValueContainer/RoomNameText

onready var ballamounttext = $VBoxContainer/BallAmount/ValueContainer/BallTotalText
onready var aimskilltext = $VBoxContainer/AimSkill/ValueContainer/AimSkillText


var ball_name_index = 1
var hoop_name_index = 1
var cage_name_index = 1
var room_name_index = 1

var ball_amount = 8
var aim_skill_level = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if visible:
		check_texts()

func check_texts():
	check_aimlevel()
	check_ballamount()
	check_ballname()
	check_cagename()
	check_hoopname()
	check_roomname()

func check_ballamount():
	if ball_amount != GameBrain.game_data["balls total"]:
		ball_amount = GameBrain.game_data["balls total"]
		ballamounttext.bbcode_text = str("[center]" + str(ball_amount) + "[/center]")

func check_aimlevel():
	if aim_skill_level != GameBrain.game_data["aim skill level"]:
		aim_skill_level = GameBrain.game_data["aim skill level"]
		aimskilltext.bbcode_text = str("[center]" + str(aim_skill_level) + "[/center]")

func check_ballname():
	if GameBrain.ball_index == 1 and ball_name_index != 1:
			ball_name_index = 1
			ballnametext.bbcode_text = str("[center] Original [/center]")
	elif GameBrain.ball_index == 2 and ball_name_index != 2:
		ball_name_index = 2
		ballnametext.bbcode_text = str("[center] Stone Ball [/center]")
	elif GameBrain.ball_index == 3 and ball_name_index != 3:
		ball_name_index = 3
		ballnametext.bbcode_text = str("[center] Obsidian Ball [/center]")
	elif GameBrain.ball_index == 4 and ball_name_index != 4:
		ball_name_index = 4
		ballnametext.bbcode_text = str("[center] Glass Ball [/center]")
	elif GameBrain.ball_index == 5 and ball_name_index != 5:
		ball_name_index = 5
		ballnametext.bbcode_text = str("[center] Slime Ball [/center]")
	elif GameBrain.ball_index == 6 and ball_name_index != 6:
		ball_name_index = 6
		ballnametext.bbcode_text = str("[center] Hammer [/center]")
	elif GameBrain.ball_index == 7 and ball_name_index != 7:
		ball_name_index = 7
		ballnametext.bbcode_text = str("[center] Fish [/center]")
	elif GameBrain.ball_index == 8 and ball_name_index != 8:
		ball_name_index = 8
		ballnametext.bbcode_text = str("[center] Knife [/center]")


func check_hoopname():
	if GameBrain.hoop_index == 1 and hoop_name_index != 1:
			hoop_name_index = 1
			hoopnametext.bbcode_text = str("[center] Backyard [/center]")
	elif GameBrain.hoop_index == 2 and hoop_name_index != 2:
		hoop_name_index = 2
		hoopnametext.bbcode_text = str("[center] SPRVLLN [/center]")
	elif GameBrain.hoop_index == 3 and hoop_name_index != 3:
		hoop_name_index = 3
		hoopnametext.bbcode_text = str("[center] Retro Hoops [/center]")
	elif GameBrain.hoop_index == 4 and hoop_name_index != 4:
		hoop_name_index = 4
		hoopnametext.bbcode_text = str("[center] Mirror [/center]")
	elif GameBrain.hoop_index == 5 and hoop_name_index != 5:
		hoop_name_index = 5
		hoopnametext.bbcode_text = str("[center] Window [/center]")

func check_cagename():
	if GameBrain.cage_index == 1 and cage_name_index != 1:
			cage_name_index = 1
			cagenametext.bbcode_text = str("[center] Ol' Red [/center]")
	elif GameBrain.cage_index == 2 and cage_name_index != 2:
		cage_name_index = 2
		cagenametext.bbcode_text = str("[center] BIGBLUE [/center]")
	elif GameBrain.cage_index == 3 and cage_name_index != 3:
		cage_name_index = 3
		cagenametext.bbcode_text = str("[center] Vector Yellow [/center]")
	elif GameBrain.cage_index == 4 and cage_name_index != 4:
		cage_name_index = 4
		cagenametext.bbcode_text = str("[center] Throne Black [/center]")
	elif GameBrain.cage_index == 5 and cage_name_index != 5:
		cage_name_index = 5
		cagenametext.bbcode_text = str("[center] Slimey Pipe [/center]")
	elif GameBrain.cage_index == 6 and cage_name_index != 6:
		cage_name_index = 6
		cagenametext.bbcode_text = str("[center] Reflective Cage [/center]")
	elif GameBrain.cage_index == 7 and cage_name_index != 7:
		cage_name_index = 7
		cagenametext.bbcode_text = str("[center] All Nets 1 [/center]")
	elif GameBrain.cage_index == 8 and cage_name_index != 8:
		cage_name_index = 8
		cagenametext.bbcode_text = str("[center] All Nets 2 [/center]")
	elif GameBrain.cage_index == 9 and cage_name_index != 9:
		cage_name_index = 9
		cagenametext.bbcode_text = str("[center] Glass Cage [/center]")

func check_roomname():
	if GameBrain.room_index == 1 and room_name_index != 1:
			room_name_index = 1
			roomnametext.bbcode_text = str("[center] Musty Arcade [/center]")
	elif GameBrain.room_index == 2 and room_name_index != 2:
		room_name_index = 2
		roomnametext.bbcode_text = str("[center] Cozy Office [/center]")
	elif GameBrain.room_index == 3 and room_name_index != 3:
		room_name_index = 3
		roomnametext.bbcode_text = str("[center] Modern White [/center]")
	elif GameBrain.room_index == 4 and room_name_index != 4:
		room_name_index = 4
		roomnametext.bbcode_text = str("[center] Modern Black [/center]")
	elif GameBrain.room_index == 5 and room_name_index != 5:
		room_name_index = 5
		roomnametext.bbcode_text = str("[center] Reflection Chamber [/center]")
	elif GameBrain.room_index == 6 and room_name_index != 6:
		room_name_index = 6
		roomnametext.bbcode_text = str("[center] Glass House [/center]")


func _on_ExitButton_pressed():
	get_tree().call_group("gameui", "done_shopping")
	visible = false


func _on_BallDownButton_pressed():
	if visible:
		GameBrain.change_ball(false)


func _on_BallUpButton_pressed():
	if visible:
		GameBrain.change_ball(true)


func _on_HoopDownButton_pressed():
	if visible:
		GameBrain.change_hoop(false)


func _on_HoopUpButton_pressed():
	if visible:
		GameBrain.change_hoop(true)


func _on_CageDownButton_pressed():
	if visible:
		GameBrain.change_cage(false)


func _on_CageUpButton_pressed():
	if visible:
		GameBrain.change_cage(true)


func _on_RoomDownButton_pressed():
	if visible:
		GameBrain.change_room(false)


func _on_RoomUpButton_pressed():
	if visible:
		GameBrain.change_room(true)


func _on_BuyBallsButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 200:
			GameBrain.game_data["tickets"] -= 200
			GameBrain.game_data["balls total"] += 1
			GameBrain.game_data["balls left"] = GameBrain.game_data["balls total"]
			Data.save()


func _on_BuyBallSkinButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 2000:
			GameBrain.game_data["tickets"] -= 2000
			GameBrain.game_data["unlocked balls"] += 1
			Data.save()


func _on_BuyHoopSkinButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 5000:
			GameBrain.game_data["tickets"] -= 5000
			GameBrain.game_data["unlocked hoops"] += 1
			Data.save()


func _on_BuyCageSkinButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 10000:
			GameBrain.game_data["tickets"] -= 10000
			GameBrain.game_data["unlocked cages"] += 1
			Data.save()


func _on_BuyRoomSkinButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 50000:
			GameBrain.game_data["tickets"] -= 50000
			GameBrain.game_data["unlocked rooms"] += 1
			Data.save()


func _on_BuyAimLevelButton_pressed():
	if visible:
		if GameBrain.game_data["tickets"] >= 500:
			GameBrain.game_data["tickets"] -= 500
			GameBrain.game_data["aim skill"] = clamp(GameBrain.game_data["aim skill"] - 0.01, 0.01, 1.0)
			GameBrain.game_data["aim skill level"] += 1
			Data.save()
