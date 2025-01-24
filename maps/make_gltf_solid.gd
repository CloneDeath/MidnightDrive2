extends Node3D

func _ready() -> void:
	for child in get_children():
		try_make_solid(child);

func try_make_solid(node: Node) -> void:
	if (node is not MeshInstance3D):
		return;
	var instance = node as MeshInstance3D;
	var body = StaticBody3D.new();
	node.add_child(body);
	var shape = CollisionShape3D.new();
	body.add_child(shape);

	var polygon = ConcavePolygonShape3D.new();
	shape.shape = polygon;
	polygon.set_faces(instance.mesh.get_faces());
