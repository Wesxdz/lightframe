extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var box = Vector2(32, 32) # box size in pixels
export var strand = 8.0 # individual line perimeter
export var thicc = 2.0 # frame line width
var strand_goal = 0.0
export var strand_diff = 8.0
export var strand_growth_rate = 1.0
export var strand_curve : Curve

# Called when the node enters the scene tree for the first time.
func _ready():
	strand_goal = strand
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if strand < strand_goal:
		strand = min(strand_goal, strand + strand_growth_rate * delta * strand_curve.interpolate_baked((strand_goal - strand)/strand_diff))
	elif strand > strand_goal:
		strand = max(strand_goal, strand - strand_growth_rate * delta * strand_curve.interpolate_baked((strand - strand_goal)/strand_diff))
	update()
	
func _draw():
	var rect = get_viewport()
	draw_circle(rect.size/2.0, 4.0, Color.whitesmoke)
	var upper_left = Vector2(rect.size.x/2 - box.x/2, rect.size.y/2 - box.y/2);
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

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			strand_goal += strand_diff
		else:
			strand_goal -= strand_diff
