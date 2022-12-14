extends Node


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


func update_sound_volume(value, vol_range, type: String) -> void:
	match type:
		"Music":
			pass
		"Sounds":
			pass


func stop_all_music() -> void:
	pass
