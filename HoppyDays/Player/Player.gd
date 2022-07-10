extends KinematicBody2D

var motion = Vector2(0,0)

const SPEED = 1000
const GRAVITY = 125
const UP = Vector2(0,-1)
const JUMP_SPEED = 2000
const WORLD_LIMIT = 3000

export var boost_multiplier = 2  #puts it in gui

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)


func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("GameState", "end_game")
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY


func boost():
	position.y -= 20
	yield(get_tree(), "idle_frame")
	motion.y = -(JUMP_SPEED * boost_multiplier)

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
		#$AudioStreamPlayerAudioStreamPlayer.stream = load("res://Hoppy_Days_Assets/SFX/jump1.ogg")
		#$AudioStreamPlayer.play()
		$JumpSFX.play()

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func animate():
	emit_signal("animate", motion)


func hurt():
	#$AudioStreamPlayer.stream = load("res://Hoppy_Days_Assets/SFX/pain.ogg")
	#$AudioStreamPlayer.play()
	$PainSFX.play() # above was tryuing to share one player with both effects, having own music player was clearer
	position.y -= 20
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED #jump when spiked
	#if lives < 0:
	#	endgame()


