extends Area2D

var velocity = Vector2.ZERO
var screen_size = OS.get_window_size()
var escape_size = 30

var x_movement
var y_movement
var persistent_rotation

func _ready():
	# Randomize Velocity and Rotation
	randomize()
	x_movement = rand_range(-100, 100)
	y_movement = rand_range(-100, 100)
	persistent_rotation = rand_range(-1,1)
	velocity = Vector2(x_movement*2,y_movement)

func _process(delta):
	# Apply random values every frame
	position += velocity * delta
	rotation += persistent_rotation * delta
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
