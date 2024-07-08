class_name RunStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

func update(delta: float):
	sprite.play("run")
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		player.velocity.x = direction * player.SPEED
	
	if direction == 0 and player.velocity.x == 0:
		transition_state.emit(self, "idle")
