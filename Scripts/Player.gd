extends Node2D

const WORLD_SIZE = preload("res://Scripts/Constants.gd").WORLD_SIZE

export (int)var _health
export (int)var _speed

# Called when the node enters the scene tree for the first time.
func _ready():
	resolveBodyParts()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Movement
	# Up:
	if Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP):
		self.translate(Vector2(0, delta * -_speed))
	# Down:
	if Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN):
		self.translate(Vector2(0, delta * _speed))
	# Left:
	if Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT):
		self.translate(Vector2(delta * -_speed, 0))
	# Right:
	if Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT):
		self.translate(Vector2(delta * _speed, 0))

	
	# Clamp to world size of 1000 x 1000
	position.x = clamp(position.x, WORLD_SIZE.x / -2, WORLD_SIZE.x / 2)
	position.y = clamp(position.y, WORLD_SIZE.y / -2, WORLD_SIZE.y / 2)

func damage(damage):
	_health -= damage
	if _health <= 0:
		_health = 0
		# TODO: Die
	
	print(_health)

# Moves the body parts to the correct positions
func resolveBodyParts():
	var children = get_children()
	children.invert()

	# Get the height of the bottom-most body part
	var bottomHeight = 0
	for child in children:
		if child is Sprite or child is AnimatedSprite:
			bottomHeight = child.get_texture().get_size().y * child.scale.y
			break

	# Move the body parts to the correct positions
	var currentHeight = 0
	for child in children:
		if child is Sprite or child is AnimatedSprite:
			var childHeight = child.get_texture().get_size().y * child.scale.y
			child.position.y = -currentHeight - childHeight / 2 + bottomHeight / 2
			currentHeight += childHeight
