class_name CameraLimits
extends Resource

@export var limit_top: int
@export var limit_left: int
@export var limit_right: int
@export var limit_bottom: int

func apply_limits(camera: Camera2D):
	camera.limit_top = limit_top
	camera.limit_left = limit_left
	camera.limit_right = limit_right
	camera.limit_bottom = limit_bottom
