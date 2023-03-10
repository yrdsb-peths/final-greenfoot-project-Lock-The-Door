class_name GameManager
extends Node2D
# Manages overall game state


signal level_started(new_level)

onready var _spawner := get_node("Enemies") as EnemySpawner
onready var _upgrade_menu := get_node("Daily Upgrade") as Control

var level = 0
export (int)var _level_count


func _ready():
	randomize()
	var status = _spawner.connect("level_completed", self, "_level_completed")
	assert(status == OK)

	if Globals.GameDataManager.game_data["Tutorial Completed"]:
		level = 1

	_spawner.read_lvl_data(level)


func _level_completed():
	print("Level complete!")

	get_node("Player").is_nonplayable = true
	
	_upgrade_menu.visible = true


func next_level():
	level += 1
	
	_spawner.read_lvl_data(level)
	get_node("Player").is_nonplayable = false
		
	emit_signal("level_started", level)
