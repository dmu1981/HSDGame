extends CharacterBody2D
class_name PlayerPawn

@export var speed : float = 100

@onready var animationPlayer = $"AnimatedSprite2D"

enum Direction { NORTH, EAST, SOUTH, WEST }

var _facing: Direction = Direction.NORTH;
var _walking: bool = false

func _process(delta):
	if Input.is_action_pressed("WalkEast"):
		_facing = Direction.EAST
		_walking = true
		animationPlayer.play("WalkEast")
	elif Input.is_action_pressed("WalkWest"):
		_facing = Direction.WEST
		_walking = true
		animationPlayer.play("WalkWest")
	elif Input.is_action_pressed("WalkNorth"):
		_facing = Direction.NORTH
		_walking = true
		animationPlayer.play("WalkNorth")
	elif Input.is_action_pressed("WalkSouth"):
		_facing = Direction.SOUTH
		_walking = true
		animationPlayer.play("WalkSouth")
	else:
		_walking = false
		if _facing == Direction.NORTH:
			animationPlayer.play("IdleNorth")
		elif _facing == Direction.EAST:
			animationPlayer.play("IdleEast")
		elif _facing == Direction.SOUTH:
			animationPlayer.play("IdleSouth")
		else:
			animationPlayer.play("IdleWest")

func _physics_process(delta):
	if _walking:
		if _facing == Direction.NORTH:
			velocity = Vector2(0.0, -1.0) * speed
		elif _facing == Direction.SOUTH:
			velocity = Vector2(0.0, 1.0) * speed
		elif _facing == Direction.EAST:
			velocity = Vector2(1.0, 0.0) * speed
		elif _facing == Direction.WEST:
			velocity = Vector2(-1.0, 0.0) * speed
	else:
		velocity = Vector2(0.0, 0.0)
		
	velocity /= Engine.time_scale
	animationPlayer.speed_scale = 1.0 / Engine.time_scale

	move_and_slide()
