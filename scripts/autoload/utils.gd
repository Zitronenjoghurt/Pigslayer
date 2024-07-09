extends Node

func boolean_xor(a: bool, b: bool) -> bool:
	return a and not b or not a and b
