extends CharacterBody2D

signal player_damaged

@export var health = 100
@export var speed = 500.0
@export var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var animation_player = $AnimatedSprite2D
@onready var player = $"../Player"
@onready var player_area = player.get_node("Area2D")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#calculate direction and apply it
	var direction = (player.position - position).normalized()
	velocity = direction * speed

	#animate the character
	if (velocity.x > 0):
		pass #animation_player.play("move_right")
	elif (velocity.x < 0):
		pass #animation_player.play("move_left")
	else:
		pass #animation_player.play("idle")

	#move the character and check collisions
	move_and_collide(velocity * _delta)

func _on_area_2d_area_entered(area):
	if (area == player_area):
		player.health -= damage
		emit_signal("player_damaged")

func _on_player_damaged():
	if (player.health <= 0):
		pass
