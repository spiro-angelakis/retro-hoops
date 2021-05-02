extends Spatial

onready var winlight = $WinLight
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("cage")

func _process(delta):
	if anim.current_animation == "win":
		if !anim.is_playing():
			anim.play("idle")

func win():
	anim.play("win")
