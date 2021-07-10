extends Node

export var x_motion = 4.0
export var y_motion = 3.0
var player
var camera
export var move_speed = 1000.0
var move_vector = Vector3.ZERO

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _enter_tree():
	player = get_node("../spectator")
	camera = get_node("../spectator/camera")
	
func _physics_process(delta):
	player.add_central_force(camera.get_global_transform().basis.z * move_vector.normalized().z * move_speed * delta)
	player.add_central_force(camera.get_global_transform().basis.x * move_vector.normalized().x * move_speed * delta)
#		player.set_linear_velocity(-camera.get_global_transform().basis.z * move_speed * delta)
#	else:
#		player.set_linear_velocity(Vector3.ZERO)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.scancode == KEY_SPACE:
			OS.set_window_fullscreen(!OS.window_fullscreen)
		if event.scancode == KEY_TAB:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if not event.echo:
			if event.scancode == KEY_W:
				move_vector += Vector3.FORWARD * (-1 + 2 * float(event.pressed))
			if event.scancode == KEY_S:
				move_vector += 0.5 * Vector3.BACK * (-1 + 2 * float(event.pressed))
			if event.scancode == KEY_D:
				move_vector += Vector3.RIGHT * (-1 + 2 * float(event.pressed))
			if event.scancode == KEY_A:
				move_vector += 0.5 * Vector3.LEFT * (-1 + 2 * float(event.pressed))
	if event is InputEventMouseMotion:
		camera.rotate_y(-event.relative.x/OS.get_window_safe_area().size.x * x_motion)
		camera.rotate_object_local(-Vector3(1.0, 0.0, 0.0), event.relative.y/OS.get_window_safe_area().size.y * y_motion)
