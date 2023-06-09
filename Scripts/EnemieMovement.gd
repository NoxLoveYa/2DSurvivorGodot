extends CharacterBody2D

signal player_damaged(damaged)

@export var health = 100
@export var points = 1
@export var speed = 500.0
@export var damage = 1
@export var attack_delay = 0.35

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var animation_player = $AnimatedSprite2D
@onready var player = $"../Player"
@onready var player_area = player.get_node("Area2D")
@onready var dt = 0
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
	dt = _delta

var lastDamage = 0

func _on_area_2d_area_entered(area):
	if (lastDamage > 0):
		lastDamage -= dt
		return
	if (area == player_area):
		emit_signal("player_damaged", damage)
		lastDamage = attack_delay

const packedGameOver = preload("res://Game_over.tscn")

func _on_player_damaged(damaged):
	health -= damaged
	if (health <= 0):
		get_tree().change_scene_to_packed(packedGameOver)
