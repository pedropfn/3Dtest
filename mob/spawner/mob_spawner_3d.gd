extends Node3D

@export var mobToSpawn: PackedScene = null

@onready var marker_3d = %Marker3D
@onready var timer = %Timer

func _on_timer_timeout() -> void:
	var newMob = mobToSpawn.instantiate()
	add_child(newMob)
	newMob.global_position = marker_3d.global_position
