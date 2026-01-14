extends Area3D

const speedBullet = 50.0
const rangeBullet = 40.0

var travelledDistance = 0.0

func _physics_process(delta):
	position += -transform.basis.z * speedBullet * delta
	travelledDistance += speedBullet * delta
	if travelledDistance > rangeBullet:
		queue_free()
