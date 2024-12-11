extends TextureRect

var w := 0.0

#animates the fog
func _process(delta: float) -> void:
	texture.noise.offset.z = w
	w += 2 * delta
