class_name IdleStatePig
extends State

@export var pig: Pig

func update(delta: float):
	pig.sprite.play("idle")
	
	pig.process_gravity(delta)
