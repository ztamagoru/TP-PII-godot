extends VBoxContainer

@onready var master_label	= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettingsLabel2/CurrentMasterVolume
@onready var master_slider	= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettings/MasterVolumeSlider
@onready var music_label	= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettingsLabel2/CurrentMusicVolume
@onready var music_slider	= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettings/MusicVolumeSlider
@onready var sfx_label		= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettingsLabel2/CurrentSFXVolume
@onready var sfx_slider		= $MarginContainer/VBoxContainer/HBoxContainer/AudioSettings/SFXVolumeSlider

func _ready():
	load_audio_settings()

func load_audio_settings():
	AudioServer.set_bus_volume_db(0, SaveManager.settings.volume_master)
	master_label.text = str(int(SaveManager.settings.volume_master))
	master_slider.value = SaveManager.settings.volume_master
	
	AudioServer.set_bus_volume_db(1, SaveManager.settings.volume_music)
	music_label.text = str(int(SaveManager.settings.volume_music))
	music_slider.value = SaveManager.settings.volume_music
	
	AudioServer.set_bus_volume_db(2, SaveManager.settings.volume_sfx)
	sfx_label.text = str(int(SaveManager.settings.volume_sfx))
	sfx_slider.value = SaveManager.settings.volume_sfx

func _on_master_volume_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(0, value)
	master_label.text = str(int(value))
	
	SaveManager.settings.volume_master = value
	SaveManager.save_settings()

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)
	music_label.text = str(int(value))
	
	SaveManager.settings.volume_music = value
	SaveManager.save_settings()

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)
	sfx_label.text = str(int(value))
	
	SaveManager.settings.volume_sfx = value
	SaveManager.save_settings()
