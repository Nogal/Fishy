extends CharacterBody2D

const MAX_SPEED = 350
const ACCEL = 750
const FRICTION = 250

var direction = "right"
var input = Vector2.ZERO

var dead = false

@onready var screen_size = get_viewport_rect().size

@onready var number_eaten = 0

signal eat_counter_increased
signal steven_died

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = self.scale * 0.5


func grow_steven_grow():
	number_eaten += 1
	var tween = get_tree().create_tween()
	get_node("Burp").play()
	if number_eaten % 5 == 0:
	#if (int(self.scale.x * 10) + 1) % 5 == 0:
		MusicPlayer._song_go_up()
	eat_counter_increased.emit(number_eaten)
	self.scale += Vector2(0.05, 0.05)
	tween.tween_property($StevenSprite, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_property($StevenSprite, "scale", Vector2(1, 1), 0.15).set_trans(Tween.TRANS_SINE)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	position.x = wrapf(position.x, 0, screen_size.x)
	#position.y = wrapf(position.y, 0, screen_size.y)
	player_movement(delta)

func player_movement(delta):
	if not dead:
		input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * ACCEL * delta)
		velocity = velocity.limit_length(MAX_SPEED)

	if input.x > 0 and get_node("StevenSprite").is_flipped_h() == true:
		get_node("StevenSprite").set_flip_h(false)
	if input.x < 0 and get_node("StevenSprite").is_flipped_h() == false:
		get_node("StevenSprite").set_flip_h(true)

	if dead:
		velocity = Vector2.ZERO
		
	move_and_slide()

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()

func die():
	dead = true
	get_node("StevenSprite").set_flip_v(true)
	MusicPlayer.queue_song(1)
	get_node("DieSound").play()
	get_tree().paused = true
	steven_died.emit()
	SceneManager.change_scene("res://src/menu/main_menu.tscn")

func _on_body_area_entered(area):
	if not dead:
		if area.size() > self.scale:
			die()
		else:
			grow_steven_grow()

