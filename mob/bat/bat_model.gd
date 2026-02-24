extends Node3D
@onready var animationTree: AnimationTree = %AnimationTree

func hurt():
	animationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
