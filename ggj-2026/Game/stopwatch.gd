extends Node
class_name Stopwatch

var time = 60.0
var stopped = false

func _process(delta):
	if stopped:
		return
	time -= delta

func reset():
	time = 60.0

func time_to_string() -> String:
	var sec = fmod(time, 60)
	var format_string = "%02d"
	var result = format_string % [sec]
	return result
	
	
