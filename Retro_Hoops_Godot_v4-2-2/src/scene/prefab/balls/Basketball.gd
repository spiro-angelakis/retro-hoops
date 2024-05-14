extends RigidBody3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var good = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_mass(GameBrain.ball_bounce_mod)
	add_to_group("ball")
	$Particles.amount = randi_range(1,5)
	
	$OmniLight.light_color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
	$OmniLight.light_energy = randf_range(0, 2)
	$OmniLight.omni_range = randf_range(2, 8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func thrown():
	$Particles.emitting = true


func grabbed():
	if !good:
		GameBrain.shots_missed += 1
	
	get_tree().call_group("game", "regain_ball")
	
	queue_free()


func _on_Timer_timeout():
	if !good:
		GameBrain.shots_missed += 1
	
	get_tree().call_group("game", "regain_ball")
	
	queue_free()


func _on_BreakArea_body_entered(body):
	if body.is_in_group("window"):
		body.smash_window()
