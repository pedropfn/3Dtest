extends Node3D

@onready var label: Label = %Label

var playerScore = 0

func increaseScore():
	playerScore += 1
	label.text = "Score: " + str(playerScore)

func _on_mob_spawner_3d_mob_spawned(mob: Variant) -> void:
	mob.mobDies.connect(increaseScore)
