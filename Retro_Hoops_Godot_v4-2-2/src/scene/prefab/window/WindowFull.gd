extends StaticBody3D


var broken_prefab = load("res://src/scene/prefab/window/WindowBroken.tscn").duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("window")
	#GameBrain.window_pos = self.global_transform.origin


func smash_window():
	var broken = broken_prefab.instantiate()
	GameBrain.current_game_parent.add_child(broken)
	broken.global_transform.origin = self.global_transform.origin
	broken.rotation_degrees = rotation_degrees
	queue_free()
