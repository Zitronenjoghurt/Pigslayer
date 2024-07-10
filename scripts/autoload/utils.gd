extends Node

func boolean_xor(a: bool, b: bool) -> bool:
	return a and not b or not a and b

func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")
