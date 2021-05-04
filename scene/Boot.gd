extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loader
var wait_frames
var time_max = 1 # msec
var current_scene



func goto_scene(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	set_process(true)
	wait_frames = 1


func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return
	
	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
		
		# poll your loader
		var err = loader.poll()
		
		
		
		if err == OK:
			update_progress()
		elif err == ERR_FILE_EOF: # load finished
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		else: # error during loading
			#show_error()
			loader = null
			break

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	#loading_screen.loadprogbar.max_value = loader.get_stage_count()
	#loading_screen.loadprogbar.value = float(loader.get_stage())
	wait_frames += 10

func set_new_scene(resource):
	var loaded_scene = resource.instance()
	get_parent().add_child(loaded_scene)
	get_parent().remove_child(self)

# Called when the node enters the scene tree for the first time.
func _ready():
	var ss = OS.get_screen_size(-1)
	#GameBrain.screen_size_vec = ss
	ProjectSettings.set_setting("display/window/size/resizable", true)
	ProjectSettings.set_setting("display/window/size/width", ss.x)
	ProjectSettings.set_setting("display/window/size/height", ss.y)
	ProjectSettings.set_setting("display/window/size/test_width", ss.x)
	ProjectSettings.set_setting("display/window/size/test_height", ss.y)
	$AnimationPlayer.play("booting")
	var data = Data.load()
	if typeof(data) == TYPE_DICTIONARY: # we have a save to load
		GameBrain.game_data = data
	else:
		pass
	goto_scene("res://scene/GameUI.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
