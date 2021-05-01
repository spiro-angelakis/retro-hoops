extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles.amount = round(rand_range(2, 16))
	$OmniLight.light_color = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1))
	$OmniLight.light_energy = rand_range(0, 2)
	$OmniLight.omni_range = rand_range(2, 8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
