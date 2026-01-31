extends Node

var total_score : int = 0

func set_total_score(value : int ) -> void:
	total_score = value

func add_total_score(amount: int) -> void:
	total_score+= amount

func get_total_score()-> int:
	return total_score
