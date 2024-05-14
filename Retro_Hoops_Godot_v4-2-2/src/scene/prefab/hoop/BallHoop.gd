extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _process(delta):
	#if GameBrain.hoop_focus != null:
		#look_at(GameBrain.hoop_focus, Vector3.UP)

func _on_ScoreArea_body_entered(body):
	if body.is_in_group("ball") and !body.good:
		GameBrain.game_data["points"] += 1
		GameBrain.game_data["unsaved_points"] += 1
		GameBrain.win_streak += 1
		GameBrain.current_streak += 1
		
		get_tree().call_group("cage", "win")
		get_tree().call_group("game", "still_streak")
		body.good = true
