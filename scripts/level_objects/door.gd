class_name Door
extends AnimatedSprite2D

@onready var spawn_point: Marker2D = %SpawnPoint

func _ready():
	play("idle")

func get_spawn_position() -> Vector2:
	return spawn_point.global_position
