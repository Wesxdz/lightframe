extends CSGMesh

const METERS_PER_CELL = 1.219
export var raycast_path : NodePath
var raycast_node

func _ready():
	raycast_node = get_node(raycast_path)

func _physics_process(delta):
	var mid = get_viewport().size/2.0
	var cam = get_node("../spectator/camera")
#	raycast_node.translation = cam.project_ray_origin(mid)
#	raycast_node.cast_to = cam.project_ray_normal(mid) * 10
	if raycast_node.is_colliding():
		var hit = raycast_node.get_collision_point()# /METERS_PER_CELL
		var point = Vector2(round(hit.x), round(hit.z))
		translation = Vector3(point.x, 0.01, point.y) * METERS_PER_CELL
