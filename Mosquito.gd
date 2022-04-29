extends Node2D

var respect_node: Node2D = null
export(NodePath) var respect = null

onready var follower := $Path2D/PathFollow2D

var fly_back := false

func _ready():
	if respect:
		respect_node = get_node(respect)

func _process(delta):
	if  fly_back:
		follower.scale.x =  sign(follower.position.x)
	else:
		follower.scale.x = -sign(follower.position.x)
	
		
func flying_back():
	fly_back = true

func start(pos:Vector2):
	position = pos
	$AnimationPlayer.play("life")

func _on_killbox_area_entered(_area): # we are dead
	$AnimationPlayer.stop()
	follower.rotate(rand_range(-PI, PI))
	$Path2D/PathFollow2D/AnimationPlayer.play("death")

func die():
	queue_free()
