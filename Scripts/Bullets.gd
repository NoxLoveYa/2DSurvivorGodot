extends AnimatableBody2D

signal enemy_damage(enemy, damage)

@export var speed = 400.0
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

@onready var player = $"../Player"

func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	if (not area_parent.name.begins_with("Enemy")):
		return
	$"..".remove_child.call_deferred(self)
	area_parent.health -= player.damage
	if (area_parent.health <= 0):
		player.score += area_parent.points
		$"../../Control/Label".text = str("Score: ", player.score)
		area_parent.free()
