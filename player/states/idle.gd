class_name IdleStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

func enter():
	player.velocity = Vector2.ZERO

func update(delta: float):
	sprite.play("idle")
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		transition_state.emit(self, "run")
