extends Node2D

var last_tap := Vector2.ZERO

func _ready():
	$AnimationPlayer.play("finger") # ???
	#get_tree().get_root().connect("size_changed", self, "window_size_changed")

func window_size_changed():
	var ws := OS.window_size
	#position = ??? center somehow ?

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			last_tap = event.position
			if $AnimationPlayer.is_playing(): return
			
			if $Timer.is_stopped():
				$Timer.start() # start of single tap
			else: # double tap
				$Timer.stop()
				hand_slap()


func _on_Timer_timeout():
	hand_finger()

func hand_slap():
	$hand_slap.position = last_tap
	$AnimationPlayer.play("slap")
	
func hand_finger():
	$hand_finger.position = last_tap
	$AnimationPlayer.play("finger")


func _on_Spawn_timeout():
	
	var mosquito := $Man/body/head/Mosquito.duplicate()
	$Man/body/head.add_child(mosquito)
	
	mosquito.start(
		Vector2(rand_range(-250,250), rand_range(-320, 412))
		)
	
	$Spawn.start(rand_range(1, 10))
