class_name Enemy
extends CharacterBody2D

@export var config: EnemyConfig
@export var sprite: AnimatedSprite2D

@export var left_vision_areas: Array[Area2D] = []
@export var right_vision_areas: Array[Area2D] = []
@export var both_vision_areas: Array[Area2D] = []

var RNG = RandomNumberGenerator.new()
var player_in_vision: Array[VisionDetectDirection] = []

signal player_detected(direction: VisionDetectDirection)
signal player_lost(direction: VisionDetectDirection)

enum VisionDetectDirection {
	LEFT,
	RIGHT,
	BOTH
}

func _ready():
	_register_vision_areas()

func _register_vision_areas():
	for area in left_vision_areas:
		area.body_entered.connect(on_vision_range_entered.bind(VisionDetectDirection.LEFT))
		area.body_exited.connect(on_vision_range_exited.bind(VisionDetectDirection.LEFT))
	for area in right_vision_areas:
		area.body_entered.connect(on_vision_range_entered.bind(VisionDetectDirection.RIGHT))
		area.body_exited.connect(on_vision_range_exited.bind(VisionDetectDirection.RIGHT))
	for area in both_vision_areas:
		area.body_entered.connect(on_vision_range_entered.bind(VisionDetectDirection.BOTH))
		area.body_exited.connect(on_vision_range_exited.bind(VisionDetectDirection.BOTH))

func _physics_process(_delta):
	move_and_slide()

func roll_intelligence(times: int=1, intelligence_multiplier: float=1.0) -> bool:
	var max_intelligence = config.INTELLIGENCE * intelligence_multiplier
	
	for i in range(times):
		var random_intelligence = RNG.randf_range(0, max_intelligence)
		var random_number = RNG.randf_range(0, 100)
		
		if random_intelligence < random_number:
			return false
	return true
	
func is_player_in_vision_range() -> bool:
	return not player_in_vision.is_empty()

func on_vision_range_entered(body: Node2D, direction: VisionDetectDirection):
	if body is Player:
		return on_player_detected(direction)
		
func on_vision_range_exited(body: Node2D, direction: VisionDetectDirection):
	if body is Player:
		return on_player_lost(direction)

func on_player_detected(direction: VisionDetectDirection):
	if player_in_vision.is_empty():
		player_detected.emit(direction)
	
	if direction not in player_in_vision:
		player_in_vision.append(direction)

func on_player_lost(direction: VisionDetectDirection):
	if direction in player_in_vision:
		player_in_vision.erase(direction)
		
	if player_in_vision.is_empty():
		player_lost.emit(direction)

func process_gravity(delta: float, gravity_factor: float=1.0):
	if not is_on_floor():
		velocity = Physics.apply_gravity(delta, velocity, config.GRAVITY_MULTIPLIER * gravity_factor)
