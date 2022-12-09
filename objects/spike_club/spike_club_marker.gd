extends Marker2D


enum Sides { LEFT, RIGHT, UP, DOWN }

@export var rotation_speed := 50.0
@export var side := Sides.LEFT

var starting_rotation: float
var ending_rotation: float
var direction := 1


func _ready() -> void:
	match side:
		Sides.LEFT:
			starting_rotation = 0
			ending_rotation = 180
		Sides.RIGHT:
			starting_rotation = 180
			ending_rotation = 360
		Sides.UP:
			starting_rotation = 80
			ending_rotation = 270
		Sides.DOWN:
			starting_rotation = -90
			ending_rotation = 90
	
	rotation = deg_to_rad(starting_rotation)


func _physics_process(delta: float) -> void:
	if rad_to_deg(rotation) < starting_rotation:
		direction = 1
	elif rad_to_deg(rotation) > ending_rotation: 
		direction = -1
	
	rotation += deg_to_rad(rotation_speed) * direction * delta
