extends RigidBody3D

@onready var batModel = %bat_model
@onready var timer = %Timer
@onready var player = get_node("/root/Game/Player")

var health = 3
var speed = randf_range(2.0, 4.0)

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	batModel.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func takeDamage():
	if health == 0:
		return

	batModel.hurt()
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(player.global_position)
		var randomUpwardForce = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10.00 + randomUpwardForce)
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()
