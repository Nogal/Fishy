extends CharacterBody2D

const MAX_SPEED = 350
const ACCEL = 750
const FRICTION = 250

var direction = "right"
var input = Vector2.ZERO

@onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = self.scale * 0.5


func grow_steven_grow():
	var tween = get_tree().create_tween()
	if (int(self.scale.x * 10) + 1) % 5 == 0:
		MusicPlayer._song_go_up()
	self.scale += Vector2(0.05, 0.05)
	tween.tween_property($StevenSprite, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_SINE)
	tween.tween_property($StevenSprite, "scale", Vector2(1, 1), 0.15).set_trans(Tween.TRANS_SINE)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	position.x = wrapf(position.x, 0, screen_size.x)
	#position.y = wrapf(position.y, 0, screen_size.y)
	player_movement(delta)

func player_movement(delta):
	input = get_input()
	
	if Input.is_action_just_released("grow_debug"):
		grow_steven_grow()
	
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


	
	move_and_slide()

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()

func die():
	MusicPlayer.queue_song(1)
	SceneManager.change_scene("res://src/menu/main_menu.tscn")

func _on_body_area_entered(area):
	if area.size() > self.scale:
		die()
	else:
		grow_steven_grow()

