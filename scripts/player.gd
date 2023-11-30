extends Area2D
signal hit

@export var speed = 400
var screen_size

var MOVE_RIGHT_ACTION = "move_right"
var MOVE_DOWN_ACTION = "move_down"
var MOVE_UP_ACTION = "move_up"
var MOVE_LEFT_ACTION = "move_left"

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed(MOVE_RIGHT_ACTION):
		velocity.x += 1
	if Input.is_action_pressed(MOVE_LEFT_ACTION):
		velocity.x -= 1
	if Input.is_action_pressed(MOVE_DOWN_ACTION):
		velocity.y += 1
	if Input.is_action_pressed(MOVE_UP_ACTION):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)