extends Node2D
var duration = .08
var opacity = .9

func _ready():
	$Particle.modulate.a = opacity
	
func _process(_delta: float) -> void:
	$Particle.modulate.a -= duration
	if $Particle.modulate.a <= 0:
		queue_free()
