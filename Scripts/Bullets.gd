extends AnimatableBody2D

@export var speed = 400.0
@export var damage = 10.0
@export var direction = Vector2(-404, -404)

# Called when the node enters the scene tree for the first time.
func _ready():
	if (direction.x == -404 or direction.y == -404):
		free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
