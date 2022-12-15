extends CanvasLayer


enum Fades { NONE, DARK, LIGHT, RESTART_LEVEL }

var last_played_anim := &""

var color_dark := Color(56, 62, 96, 255)
var color_light := Color(255, 255, 255, 255)

@onready var _scene_tree := get_tree()
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var logo_screen: PackedScene = preload("res://ui/logo_screen.tscn")

func _ready() -> void:
	change_scene(logo_screen, SceneManager.Fades.DARK)


func change_scene(new_scene: PackedScene, fade := Fades.NONE) -> void:
	var animation := &""
	match fade:
		Fades.DARK:
			color_rect.color = color_dark
			animation = &"dark_fade"
		Fades.LIGHT:
			color_rect.color = color_dark
			animation = &"light_fade"
		Fades.RESTART_LEVEL:
			color_rect.color = color_dark
			animation = &"restart_level_fade"
		Fades.NONE:
			animation = &""
	
	if animation != &"":
		animation_player.play(animation)
		last_played_anim = animation
	
	_scene_tree.change_scene_to_packed(new_scene)


func get_anim_duration() -> float:
	if last_played_anim == &"":
		return 0.0
	
	return animation_player.get_animation(last_played_anim).length
