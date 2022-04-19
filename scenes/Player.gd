extends Area2D

var velocity = Vector2.ZERO
var screen_size = OS.get_window_size()
var escape_size = 12

export(int) var rotation_speed = 5
export(float) var thrust_strength = 10
var thrust = 0

func _ready():
	# Spawn Player at the center of the Screen
	position = screen_size/2

func _process(delta):
	# Get Input and rotate player
	var rot = Input.get_axis("Left", "Right") * rotation_speed
	rotate(rot * delta)

	# Move with thrust
	thrust = Input.get_action_strength("Thrust")
	velocity += transform.x * thrust * thrust_strength
	velocity = lerp(velocity, Vector2.ZERO, 1 * delta)
	position += velocity * delta
	wrap()

func wrap():
	screen_size = OS.get_window_size()

	# Wraparound left and right
	if position.x < -escape_size:
		position.x = screen_size.x + escape_size
	elif position.x > screen_size.x + escape_size:
		position.x = -escape_size

	# Wraparound top and bottom
	if position.y < -escape_size:
		position.y = screen_size.y + escape_size
	elif position.y > screen_size.y + escape_size:
		position.y = -escape_size
