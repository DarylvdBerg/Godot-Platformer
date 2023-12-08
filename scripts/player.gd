extends CharacterBody2D


@export var speed: int
var _screen_size
var _normal_speed
var _dash_speed

func _ready():
	_screen_size = get_viewport_rect().size
	_normal_speed = speed
	_dash_speed = speed * 2

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("dash"):
		speed = _dash_speed
	else:
		speed = _normal_speed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("walk")
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, _screen_size)
	else:
		$AnimatedSprite2D.stop()
