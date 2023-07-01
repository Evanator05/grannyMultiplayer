extends Node

@export var randomBits:Array[AudioStream]
@export var mainTrack:AudioStream

func _ready():
	randomize()
	play()
	
func play():
	await get_tree().create_timer(randf_range(10,45)).timeout
	$randomBits.stream = randomBits.pick_random()
	$randomBits.play()
	play()
