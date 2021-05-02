extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ScoreArea_body_entered(body):
	if body.is_in_group("ball"):
		GameBrain.game_data["points"] += 1
		get_tree().call_group("cage", "win")
		body.good = true
