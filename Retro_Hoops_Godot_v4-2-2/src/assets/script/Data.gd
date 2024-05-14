extends Node

const FILE_NAME = "user://retrohoops-data.json"

func _ready():
	var d = load_game()
	if typeof(d) == TYPE_DICTIONARY:
		GameBrain.game_data = d
		GameBrain.game_data["points"] = 0
		GameBrain.game_data["level"] = 1
		
		GameBrain.game_data["balls left"] = GameBrain.game_data["balls total"]

func save():
	var file = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	var data = GameBrain.game_data
	data["all-time points"] += data["unsaved_points"]
	data["unsaved_points"] = 0
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if FileAccess.file_exists(FILE_NAME):
		var file = FileAccess.open(FILE_NAME, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			return data
		else:
			return -2
	else:
		return -1
