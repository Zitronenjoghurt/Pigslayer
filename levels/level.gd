class_name Level
extends Node2D

@export var data: LevelData
@export var entrance_door: Door

func _ready():
	spawn_player()

func spawn_player():
	var player_scene = load(Paths.PLAYER_SCENE)
	var player = player_scene.instantiate() as Player
	
	var player_spawn_properties = PlayerSpawnProperties.new()
	player_spawn_properties.spawn_position = entrance_door.get_spawn_position()
	player_spawn_properties.camera_limits = data.camera_limits
	add_child(player)
	player.on_spawn(player_spawn_properties)
