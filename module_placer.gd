extends Node

export var grid_path : NodePath
onready var grid = get_node(grid_path)
var wall_module_prefab = preload("res://wall_module.tscn")

func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseButton: #TODO Modes for FPS/UI interaction/top down/etc
		if event.button_index == 1 and event.pressed:
			var wall = wall_module_prefab.instance() 
			get_node("../build").add_child(wall)
			wall.translation = grid.translation
			var to_player = grid.translation - get_node("../spectator").translation
			var facing = round((Vector2(to_player.x, -to_player.z).angle() + (PI/2)) / (PI/2)) * (PI/2)
			print(facing)
			wall.rotate_y(facing)
