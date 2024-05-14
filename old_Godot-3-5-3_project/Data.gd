extends Node

const FILE_NAME = "user://retrohoops-data.json"


func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	var data = GameBrain.game_data
	data["all-time points"] += data["points"]
	data["points"] = 0
	file.store_string(to_json(data))
	file.close()

func load_game():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			return data
		else:
			return -2
	else:
		return -1