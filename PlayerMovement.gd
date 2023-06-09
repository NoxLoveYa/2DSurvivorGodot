extends CharacterBody2D

@export var Velocity = 500.0

@export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var bullet_scene: PackedScene = preload("res://Bullet.tscn")

@onready var animation_player = $AnimatedSprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	if (Input.is_action_pressed("player_primary_attack")):
		var bullet = bullet_scene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		bullet.direction = Vector2(1,1)
		add_child(bullet)
		
