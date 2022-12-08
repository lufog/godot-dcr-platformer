extends StaticBody2D


enum States { IDLE, CLOSE, OPEN }

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var collision: CollisionShape2D = $Collision

var state := States.IDLE
var is_closed := true
var state_queue: Array[States]


func _process(_delta: float) -> void:
	match state:
		States.IDLE:
			animated_sprite.play("idle")
		
		States.CLOSE:
			if not is_closed:
				collision.disabled = false
				animated_sprite.play("close")
				await animated_sprite.animation_finished
				is_closed = true
				state = States.IDLE
		
		States.OPEN:
			if is_closed:
				animated_sprite.play("open")
				await animated_sprite.animation_finished
				collision.disabled = true
				is_closed = false
	
	if state_queue.size() > 0:
		var next_state := state_queue.back() as States
		
		if state == next_state:
			return
		
		if next_state == States.CLOSE:
			if state == States.IDLE:
				state_queue.clear()
				return
		
			if state == States.OPEN:
				state = States.CLOSE
				state_queue.clear()
				return
		
		if next_state == States.OPEN:
			state = States.OPEN
			state_queue.clear()


func close_stone_gate() -> void:
	state_queue.append(States.CLOSE)


func open_stone_gate() -> void:
	state_queue.append(States.OPEN)
