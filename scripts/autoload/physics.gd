extends Node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_constant_drag_x(delta: float, vec: Vector2, drag: float) -> Vector2:
	if vec.x > 0:
		vec.x -= delta * drag
		if vec.x < 0:
			vec.x = 0
	elif vec.x < 0:
		vec.x += delta * drag
		if vec.x > 0:
			vec.x = 0
	return vec

func apply_linear_drag_x(delta: float, vec: Vector2, drag: float, max_speed: float) -> Vector2:
	var drag_strength = abs(vec.x) / max_speed
	return apply_constant_drag_x(delta, vec, drag * drag_strength)
	
func apply_logarithmic_drag_x(delta: float, vec: Vector2, drag: float, max_speed: float) -> Vector2:
	var drag_strength = log(1 + abs(vec.x) / max_speed)
	return apply_constant_drag_x(delta, vec, drag * drag_strength)
	
func apply_exp_decay_drag_x(delta: float, vec: Vector2, drag: float, max_speed: float, decay_exponent: float) -> Vector2:
	var drag_strength = exp(-abs(vec.x) / max_speed * decay_exponent)
	return apply_constant_drag_x(delta, vec, drag * drag_strength)

func apply_constant_drag_y(delta: float, vec: Vector2, drag: float) -> Vector2:
	if vec.y > 0:
		vec.y -= delta * drag
		if vec.y < 0:
			vec.y = 0
	elif vec.y < 0:
		vec.y += delta * drag
		if vec.y > 0:
			vec.y = 0
	return vec

func apply_gravity(delta: float, vec: Vector2, factor: float) -> Vector2:
	vec.y += delta * gravity * factor
	return vec

func limit_vector(vec: Vector2, value: float) -> Vector2:
	vec = limit_vector_x(vec, value)
	return limit_vector_y(vec, value)

func limit_vector_x(vec: Vector2, value: float) -> Vector2:
	if vec.x > value:
		vec.x = value
	elif vec.x < -value:
		vec.x = -value
	return vec

func limit_vector_y(vec: Vector2, value: float) -> Vector2:
	if vec.y > value:
		vec.y = value
	elif vec.y < -value:
		vec.y = -value
	return vec
