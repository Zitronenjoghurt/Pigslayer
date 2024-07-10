class_name IdleStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

func update(delta: float):
	sprite.play("idle")
	
	player.process_gravity(delta)
	player.process_horizontal_drag(delta, player.config.IDLE_DRAG_MULTIPLIER)
	
	if Utils.boolean_xor(Input.is_action_pressed("Left"), Input.is_action_pressed("Right")):
		transition_state.emit(self, "walk")
	
	if Input.is_action_just_pressed("Up"):
		transition_state.emit(self, "jump")
