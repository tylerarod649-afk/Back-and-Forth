extends Node2D

@export var character_speed: float = 120.0


var curr_direction: Vector2 = Vector2.RIGHT
@onready var curr_position: Vector2 = $Character.position
@export var character: Node2D
var balls = 3

func _process(delta: float) -> void:
	if balls == 3:
		$Energy.scale.x = .5
	if balls == 2:
		$Energy.scale.x = .33
	if balls == 1:
		$Energy.scale.x = .168
	if balls == 0:
		$Energy.scale.x = 0
	
	
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1

	if direction != Vector2.ZERO:
		curr_direction = direction.normalized()

		$Character.position += curr_direction * character_speed * delta
		$Character.global_rotation = curr_direction.angle()


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_UP and event.pressed and not event.echo and balls > 0:
		balls -=1
		var ball = preload("res://Ball.tscn").instantiate()

		ball.target = $Character
		ball.direction = curr_direction

		get_tree().current_scene.add_child(ball)

		ball.global_position = $Character.global_position
