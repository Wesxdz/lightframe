tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var box = Vector2(32, 32) # box size in pixels
export var strand = 12.0 # individual line perimeter
export var thicc = 2.0 # frame line width

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	
func _draw():
	var rect = OS.get_window_safe_area()
	var upper_left = Vector2(rect.position.x + rect.size.x/2 - box.x/2,rect.position.y + rect.size.y/2 - box.y/2);
	draw_line(upper_left, upper_left + Vector2(strand, 0), Color(255, 255, 255), thicc, true)
	draw_line(upper_left, upper_left + Vector2(0, strand), Color(255, 255, 255), thicc, true)
	
	var lower_left = upper_left + Vector2(0, box.y)
	draw_line(lower_left, lower_left + Vector2(strand, 0), Color(255, 255, 255), thicc, true)
	draw_line(lower_left, lower_left - Vector2(0, strand), Color(255, 255, 255), thicc, true)
	
	var upper_right = upper_left + Vector2(box.x, 0)
	draw_line(upper_right, upper_right - Vector2(strand, 0), Color(255, 255, 255), thicc, true)
	draw_line(upper_right, upper_right + Vector2(0, strand), Color(255, 255, 255), thicc, true)
	
	var lower_right = upper_left + box
	draw_line(lower_right, lower_right - Vector2(strand, 0), Color(255, 255, 255), thicc, true)
	draw_line(lower_right, lower_right - Vector2(0, strand), Color(255, 255, 255), thicc, true)
