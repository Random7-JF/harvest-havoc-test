extends Node2D
class_name TileMapManager

signal farm_mode_changed()

@export_category("Tilemap Settings")
@export var ground_layer: int = 0
@export var farmland_layer: int = 1
@export var farmland_terrain_set: int = 0
@export var farmland_terrain_id: int = 0

@onready var tilemap: TileMap = $TileMap

const CAN_PLACE_FARMLAND: String = "can_place_farmland"

var _farm_mode: bool = false: get = get_farm_mode

func get_farm_mode() -> bool:
	return _farm_mode


func _input(event):
	if Input.is_action_just_pressed("farm_mode"):
		_farm_mode = !_farm_mode
		emit_signal("farm_mode_changed")
	
	if Input.is_action_just_pressed("mouse_left"):
		var mouse_coords: Vector2 = get_global_mouse_position()
		var tile_coords: Vector2i = tilemap.local_to_map(mouse_coords)
		if _farm_mode:
			update_terrian(tile_coords, farmland_terrain_set, farmland_terrain_id)


func update_terrian(tile_coords: Vector2i, terrain_set: int, terrain_id: int):
	var tile_data: TileData = tilemap.get_cell_tile_data(ground_layer, tile_coords)
	if tile_data:
		var tile_farmland: bool = tile_data.get_custom_data(CAN_PLACE_FARMLAND)
		if tile_farmland:
			var farmland: Array[Vector2i] = []
			farmland.append(tile_coords)
			print("farmland array: ", farmland)
			tilemap.set_cells_terrain_connect(ground_layer, farmland, terrain_set, terrain_id)
