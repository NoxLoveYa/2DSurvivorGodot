extends CharacterBody2D

@export var score = 0

@export var health = 100
@export var Velocity = 500.0

@export var shoot_delay = 100.0
@export var damage = 10.0

func _ready():
	pass

var bullet_scene: PackedScene = load("res://Bullet.tscn")

@onready var animation_player = $AnimatedSprite2D
@onready var lastShot = shoot_delay / 1000

func _process(_delta):
	#reset velocity to have sharp movement
	velocity = Vector2(0.0, 0.0)
	
	#handle inputs
	if (Input.is_action_pressed("move_right")):
		velocity.x += Velocity
	if (Input.is_action_pressed("move_left")):
		velocity.x -= Velocity
		
	if (Input.is_action_pressed("move_up")):
		velocity.y -= Velocity
	if (Input.is_action_pressed("move_down")):
		velocity.y += Velocity
	
	#animate the character
	if (velocity.x > 0):
		animation_player.play("move_right")
	elif (velocity.x < 0):
		animation_player.play("move_left")
	else:
		animation_player.play("idle")
	
	#move the character and check collisions
	move_and_collide(velocity * _delta)
	
	#shooting logic
	if (lastShot <= 0):
		if (Input.is_action_pressed("player_primary_attack")):
			var bullet = bullet_scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
			bullet.direction = (get_global_mouse_position() - position).normalized()
			var direction = 1
			if (Input.is_action_pressed("move_left")):
				direction = -1
			bullet.position = position + Vector2(35 * direction, -10)
			$"..".add_child(bullet)
			lastShot = shoot_delay / 1000
	else:
		lastShot -= _delta
