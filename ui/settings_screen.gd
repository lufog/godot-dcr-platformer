extends Control


var next_scene_path := ^"res://ui/title_screen.tscn"
var music_vol_range := 10.0
var sounds_vol_range := 10.0

@onready var music_scroll_bar: HScrollBar = $VBoxContainer/MusicScrollBar
@onready var sounds_scroll_bar: HScrollBar = $VBoxContainer/SoundsScrollBar


func _ready() -> void:
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()
	
	if SoundManager.music_scroll_vol_current != null:
		music_scroll_bar.value = SoundManager.music_scroll_vol_current
	if SoundManager.sounds_scroll_vol_current != null:
		sounds_scroll_bar.value = SoundManager.sounds_scroll_vol_current


func _on_back_button_up() -> void:
	get_tree().change_scene_to_file(next_scene_path)


func _on_back_button_down() -> void:
	SoundManager.button_sound.play()


func _on_music_scroll_bar_scrolling() -> void:
	SoundManager.update_sound_volume(music_scroll_bar.value, music_vol_range, &"Music")


func _on_sounds_scroll_bar_scrolling() -> void:
	SoundManager.update_sound_volume(sounds_scroll_bar.value, sounds_vol_range, &"Sounds")
