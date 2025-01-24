@tool
extends MeshInstance3D

@export var resolution: Vector2 = Vector2(10, 10) :
	get:
		return resolution;
	set(value):
		resolution = value;
		update_shader_parameters();

func _ready() -> void:
	update_shader_parameters();
	if (!Engine.is_editor_hint()):
		visible = true;

func update_shader_parameters():
	var material: ShaderMaterial = self.get_active_material(0);
	material.set_shader_parameter("resolution", resolution);
