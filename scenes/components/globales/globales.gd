extends Node

var main_menu
var jugador
var current_level

var current_slot : int = 1
var object_inventory : Array = []
var unlocked_levels : Array = []
var death_counter : int

func add_death():
	death_counter += 1
	SaveManager.game.death_counter = death_counter
	SaveManager.save_game()

func add_collectible(item_id : String):
	if item_id in object_inventory:
		return
	
	object_inventory.append(item_id)
	SaveManager.game.collected_items = object_inventory
	SaveManager.save_game()

func clear_data():
	object_inventory.clear()
	unlocked_levels.clear()
	death_counter = 0

func load_game():
	SaveManager.load_game()
	
	object_inventory = SaveManager.game.collected_items
	unlocked_levels = SaveManager.game.unlocked_levels
	death_counter = SaveManager.game.death_counter
	
