extends Node3D

@onready var winlight = $WinLight
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count() - 1:
		get_node("CSGCombiner").add_to_group("hard")
	add_to_group("hard")
	add_to_group("cage")

func _process(delta):
	if anim.current_animation == "win":
		if !anim.is_playing():
			anim.play("idle")

func win():
	anim.play("win")
	Data.save()


func _on_BallReturnArea_body_entered(body):
	if body.is_in_group("ball"):
		body.grabbed()
