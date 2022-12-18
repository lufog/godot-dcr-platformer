extends Control


var next_scene: PackedScene = SceneManager.logo_screen

var counter := 0
var scroll_speed := 10.0

var credit_list := [
	["Game Director", "DCR",],
	["Programming", "DCR"],
	["Art", "https://o-lobster.itch.io/"],
	["Animation", "https://o-lobster.itch.io/"],
	["Level Design", "DCR"],
	["Music", "Matthew Pablo \n (http://www.matthewpablo.com)" ],
	["Sound Effects", "Jalastram \n Jesus Lastra \n Virix David McKee \n NenadSimic \n qubodup \n Lamoot \n Macro"],
	["Font", "Kenney Pixel"],
	["Programs", "Krita \n Godot"],
	["Thank You!", "DCR"]
]

@onready var title_label: Label = $VBoxContainer/TitleLabel
@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer


func _ready() -> void:
	SoundManager.stop_all_music()
	SoundManager.ending_music.play()
	timer.start()


func _process(delta: float) -> void:
	parallax_background.offset.x -= scroll_speed * delta


func _on_timer_timeout() -> void:
	title_label.text = credit_list[counter][0]
	name_label.text = credit_list[counter][1]
	animation_player.play("FadeInNOut")
	counter += 1
	if counter >= credit_list.size():
		timer.stop()
		SceneManager.change_scene(next_scene, SceneManager.Fades.DARK)
