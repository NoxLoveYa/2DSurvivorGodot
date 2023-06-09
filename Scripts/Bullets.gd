extends AnimatableBody2D

@export var speed = 400.0
@export var damage = 10.0
@export var direction = Vector2(-404, -404)

func calculateRotationAngle(dir: Vector2) -> float:
	return rad_to_deg(atan2(dir.x, -dir.y))

# Called when the node enters the scene tree for the first time.
func _ready():
	if (direction.x == -404 or direction.y == -404):
		$"..".remove_child.call_deferred(self)
	else:
		rotation = calculateRotationAngle(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_collide(direction * speed * _delta)
	if (position.x > 1920 or position.x < 0):
		$"..".remove_child.call_deferred(self)
	elif (position.y > 1080 or position.y < 0):
		$"..".remove_child.call_deferred(self)
