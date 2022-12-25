extends TextureRect

const WORLD_SIZE = preload("res://Scripts/Constants.gd").WORLD_SIZE

func _ready():
	setSize()
	get_tree().get_root().connect("size_changed", self, "setSize")
	
	
func setSize():
	# get window size
	var window_size = get_viewport_rect().size
	# set size of the texture
	set_size(WORLD_SIZE + window_size)
	# set position of the texture
	set_position(-get_rect().size / 2)
