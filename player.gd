extends CharacterBody2D


@onready var bullet_scene = preload("res://Bullet.tscn")

const SPEED = 110.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D


var push_force = 20.0   
			
func _ready():
	GlobalVariables.set_player(self)
			
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("Jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	#var is_dropping = Input.is_action_pressed("drop")
	#if (is_dropping):
		#set_collision_mask_value(3, false)
	#else:
		#set_collision_mask_value(3, true)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal = Input.get_axis("move_left", "move_right")
	var vertical = Input.get_axis("move_up", "move_down")
	
	
	if (horizontal > 0):
		animated_sprite_2d.flip_h = false
	elif horizontal < 0:
		animated_sprite_2d.flip_h = true
	
	if (is_on_floor()):
		if (horizontal == 0):
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Jump")
	
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	 # after calling move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)


func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		var mousePos = get_viewport().get_mouse_position()
		var bullet = bullet_scene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.position = position
		var MouseCenter = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
		bullet.rotation =  (mousePos - MouseCenter).normalized().angle()
		get_parent().get_parent().add_child(bullet)


func _on_health_health_depleted():
	pass # Replace with function body.
