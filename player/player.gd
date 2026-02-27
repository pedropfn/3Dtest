extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # pre built function to keep the mouse on the game

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= (event.relative.x * 0.3) # applying camera y movement in the entire player
		%Camera3D.rotation_degrees.x -= (event.relative.y * 0.3) # applying camera x movement only in the player vision node
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 60.0) # limiting player vision x rotation
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # pre built function to release the mouse pressing esc
		
func _physics_process(delta):
	const speed = 5.5 # mps
	var inputDirection2d = Input.get_vector("move_left", "move_right", "move_forward", "move_back") # defined on project setting > input maps
	var inputDirection3d = Vector3(inputDirection2d.x, 0.0, inputDirection2d.y) # converting the movement to 3d
	var direction = transform.basis * inputDirection3d # converting orientation, position, scale of player node to character coordinate system
	
	# applying velocity to the character movement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= 20.0 * delta # creating gravity, multiplaying direction to time
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0 # go up to the max jump length
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0 # stop going up on release jump button
	elif Input.is_action_pressed("shoot") and %Timer.is_stopped():
		shootBullet()
	move_and_slide()
	
func shootBullet():
	const BULLET_3D = preload("uid://t00gdrxxtiwh")
	var newBullet = BULLET_3D.instantiate()
	
	%Marker3D.add_child(newBullet)
	newBullet.global_transform = %Marker3D.global_transform
	%Timer.start()
	%AudioStreamPlayer.play()
	
