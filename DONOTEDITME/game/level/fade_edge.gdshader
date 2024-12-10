shader_type canvas_item;

uniform float inner_threshold = 0.2;
uniform float outer_threshold = 0.05;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (UV.x < inner_threshold) {
		COLOR.a = min(COLOR.a, (UV.x - outer_threshold) / (inner_threshold - outer_threshold));
		if (COLOR.a < 0.0) {
			COLOR.a = 0.0;
		}
	}
	
	if (UV.x > 1.0 - inner_threshold) {
		COLOR.a = min(COLOR.a, ((1.0 - UV.x) - outer_threshold) / (inner_threshold - outer_threshold));
		if (COLOR.a < 0.0) {
			COLOR.a = 0.0;
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
