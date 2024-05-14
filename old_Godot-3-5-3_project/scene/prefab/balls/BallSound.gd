extends Spatial


var swished = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_parent().good and !swished:
		swished = true
		$SwishSound.play()


func _on_TouchArea_body_entered(body):
	$BounceSound.play()


func _on_TouchArea_area_entered(area):
	if area.is_in_group("hard"):
		$BounceSound.play()
