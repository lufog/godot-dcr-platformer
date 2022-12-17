extends Node


enum _BusIdx { MASTER = 0, MUSIC = 1, SOUNDS = 2 }

var music_scroll_vol_current
var sounds_scroll_vol_current

@onready var music: Node = $Music
@onready var title_screen_music: AudioStreamPlayer = $Music/TitleScreenMusic
@onready var game_play_music: AudioStreamPlayer = $Music/GamePlayMusic
@onready var ending_music: AudioStreamPlayer = $Music/EndingMusic

@onready var sounds: Node = $Sounds
@onready var attack_sound: AudioStreamPlayer = $Sounds/AttackSound
@onready var button_sound: AudioStreamPlayer = $Sounds/ButtonSound
@onready var dash_sound: AudioStreamPlayer = $Sounds/DashSound
@onready var death_sound: AudioStreamPlayer = $Sounds/DeathSound
@onready var jump_sound: AudioStreamPlayer = $Sounds/JumpSound
@onready var land_sound: AudioStreamPlayer = $Sounds/LandSound
@onready var level_complete_sound: AudioStreamPlayer = $Sounds/LevelCompleteSound
@onready var logo_sound: AudioStreamPlayer = $Sounds/LogoSound


func update_sound_volume(value, vol_range, type: StringName) -> void:
	match type:
		&"Music":
			AudioServer.set_bus_volume_db(_BusIdx.MUSIC, linear_to_db(value))
			music_scroll_vol_current = value
		&"Sounds":
			AudioServer.set_bus_volume_db(_BusIdx.SOUNDS, linear_to_db(value))
			sounds_scroll_vol_current = value


func stop_all_music() -> void:
	for child in music.get_children():
		var music_player := child as AudioStreamPlayer
		if music_player != null and music_player.playing:
			music_player.stop()
