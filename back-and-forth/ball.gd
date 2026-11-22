extends Node2D

@export var move_speed: float = 1000.0
@export var return_speed: float = 1000.0
@export var return_after: float = 0.5
@export var trail_interval: float = 0.001

var count = 0

var target: Node2D
var direction: Vector2 = Vector2.RIGHT

var elapsed_time: float = 0.0
var trail_timer: float = 0.0
var returning: bool = false


func _ready() -> void:
	direction = direction.normalized()


func _process(delta: float) -> void:

	$Ball_Sprite.rotation += deg_to_rad(100)
	count += 1
	elapsed_time += delta

	# Initial movement away from the character
	if not returning:
		global_position += direction * move_speed * delta

		# Start returning after the specified time
		if elapsed_time >= return_after:
			returning = true

	# Return toward the character
	else:
		if not is_instance_valid(target):
			queue_free()
			return

		global_position = global_position.move_toward(
			target.global_position,
			return_speed * delta
		)

		# Remove the ball when it reaches the character
		if global_position.distance_to(target.global_position) < 12.0:
			get_parent().balls +=1
			queue_free()
			return

	# Particle trail
	trail_timer += delta

	if trail_timer >= trail_interval:
		trail_timer = 0.0

		var particle = preload("res://particle.tscn").instantiate()
		get_tree().current_scene.add_child(particle)

		particle.global_position = $Ball_Sprite.to_global($Ball_Sprite.offset)
