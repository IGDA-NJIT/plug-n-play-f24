shader_type canvas_item;

uniform int tiles = 5;
uniform float seconds_per_cycle = 5.0;
uniform vec4 pixel_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	// Compute the tiling of the background
	float tile_height = 1.0 / SCREEN_PIXEL_SIZE.y / float(tiles);
	float tile_width = tile_height / (1.0 / SCREEN_PIXEL_SIZE.x);
	tile_height /= (1.0 / SCREEN_PIXEL_SIZE.y);
	
	// Compute the time shift
	float test = mod(TIME, seconds_per_cycle) / seconds_per_cycle;
	
	// Called for every pixel the material is visible on.
	vec2 tx = vec2(UV.x / tile_width, UV.y / tile_height);
	vec2 txrounded = vec2(floor(UV.x / tile_width), floor(UV.y / tile_height));
	tx -= txrounded;
	tx += vec2(test, test);
	if (tx.x > 1.0) {
		tx.x -= 1.0;
	}
	
	if (tx.y > 1.0) {
		tx.y -= 1.0;
	}
	vec4 pixel = texture(TEXTURE, tx);
	if (pixel.a != 0.0) {
		COLOR = pixel_color;
	} else {
		discard;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
