extends Button
class_name RemapButton

@export var action : String

static var active_remap_button : RemapButton = null

func _init():
	toggle_mode = true
	#theme_type_variation = "RemapButton"

func _ready():
	set_process_unhandled_input(false)
	update_key_text()

func _toggled(button_pressed : bool):
	set_process_unhandled_input(button_pressed)
	
	if button_pressed:
		if active_remap_button and active_remap_button != self:
			active_remap_button.button_pressed = false
		
		text = "... Awaiting Input ..."
		active_remap_button = self
		grab_focus()
	else:
		if active_remap_button == self:
			active_remap_button = null
		
		update_key_text()
		release_focus()

func _unhandled_input(event : InputEvent):
	if event is InputEventKey and event.pressed:
		var key_display = event.keycode
		var key_physical = event.physical_keycode
		
		var is_letter = key_display >= KEY_A and key_display <= KEY_Z
		var is_number = (key_display >= KEY_0 and key_display <= KEY_9) or (key_display >= KEY_KP_0 and key_display <= KEY_KP_9)
		var is_space = key_display == KEY_SPACE
		
		if is_letter or is_number or is_space:
			print(key_display, ", ", key_physical, ", already used: ", is_key_already_assigned(key_physical))
			
			if not is_key_already_assigned(key_physical):
				var new_event = InputEventKey.new()
				
				new_event.physical_keycode = key_physical
				new_event.keycode = key_display
				new_event.pressed = false
				
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, new_event)
		
		button_pressed = false

func is_key_already_assigned(key_physical : int):
	for act in InputMap.get_actions():
		if act == action:
			continue
		
		for ev in InputMap.action_get_events(act):
			if ev is InputEventKey and ev.physical_keycode == key_physical:
					return true
	
	return false 

func update_key_text():
	text = "%s" % InputMap.action_get_events(action)[0].as_text()
