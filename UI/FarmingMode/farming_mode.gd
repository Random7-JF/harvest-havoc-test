extends HBoxContainer

@export var tilemap_manager: TileMapManager

@onready var current_mode: Label = $CurrentMode

func _ready():
	tilemap_manager.connect("farm_mode_changed", update_mode)
	update_mode()
	
func update_mode() -> void:
	current_mode.text = str(tilemap_manager.get_farm_mode())
