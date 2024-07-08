extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_drag_x(delta: float, vec: Vector2, drag: float) -> Vector2:
	if vec.x > 0:
		vec.x -= delta * drag
		if vec.x < 0:
			vec.x = 0
	elif vec.x < 0:
		vec.x += delta * drag
		if vec.x > 0:
			vec.x = 0
	return vec

func apply_drag_y(delta: float, vec: Vector2, drag: float) -> Vector2:
	if vec.y > 0:
		vec.y -= delta * drag
		if vec.y < 0:
			vec.y = 0
	elif vec.y < 0:
		vec.y += delta * drag
		if vec.y > 0:
			vec.y = 0
	return vec

func apply_gravity(delta: float, vec: Vector2) -> Vector2:
	vec.y += delta * gravity
	return vec
