class_name Enemy
extends CharacterBody2D

@export var config: EnemyConfig
@export var sprite: AnimatedSprite2D

var RNG = RandomNumberGenerator.new()

func _physics_process(delta):
	move_and_slide()

func roll_intelligence(times: int = 1, intelligence_multiplier: float = 1.0) -> bool:
	var max_intelligence = config.INTELLIGENCE * intelligence_multiplier
	
	for i in range(times):
		var random_intelligence = RNG.randf_range(0, max_intelligence)
		var random_number = RNG.randf_range(0, 100)
		
		if random_intelligence < random_number:
			return false
	return true

func process_gravity(delta: float, gravity_factor: float=1.0):
	if not is_on_floor():
		velocity = Physics.apply_gravity(delta, velocity, config.GRAVITY_MULTIPLIER * gravity_factor)
