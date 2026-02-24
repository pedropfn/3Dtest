extends RigidBody3D

@onready var batModel: Node3D = %bat_model

func takeDamage():
	batModel.hurt()
