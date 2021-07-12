extends Node

export var grid_path : NodePath
onready var grid = get_node(grid_path)
var wall_module_prefab = preload("res://wall_module.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			var wall = wall_module_prefab.instance() 
			get_node("../build").add_child(wall)
			wall.translation = grid.translation
