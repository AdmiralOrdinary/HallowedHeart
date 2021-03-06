extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")
const DeathMenu = preload("res://Menu/DeathMenu.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500
#export var DAMAGE = PlayerStats.damage

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	blinkAnimationPlayer.play("Stop")
	swordHitbox.damage = 1
	randomize()
	stats.connect("no_health", self, "_on_PlayerStats_no_health")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	stats.connect("damage_change", self, "add_damage")
	stats.connect("damage_set", self, "set_damage")
	stats.connect("checkpoint", self, "checkpoint")
	
func checkpoint():
	print("checkpoint")
	self.position.x = PlayerStats.playerStartPosition_X
	self.position.y = PlayerStats.PlayerStartPosition_Y
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state()
			
		ATTACK:
			attack_state()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("roll"):
		PlayerStats.rolls += 1
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func roll_state():
	hurtbox.start_roll(0.3)
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func move():
	velocity = move_and_slide(velocity)

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func roll_animation_finished():
	#PlayerStats.rolls += 1
	velocity = velocity * 0.8
	state = MOVE

func attack_animation_finished():
	state = MOVE
	
func add_damage(value):
	swordHitbox.damage += value
	
func set_damage(value):
	swordHitbox.damage = value

func _on_Hurtbox_area_entered(area):
	PlayerStats.damageTaken += 1
	stats.health -= area.damage
	hurtbox.start_invincibility(1)
	hurtbox._create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")


func _on_PlayerStats_no_health():
	PlayerStats.deaths += 1
	var deathMenu = DeathMenu.instance()
	get_tree().get_root().get_node("World/UI").add_child(deathMenu)
	#queue_free()
	get_tree().paused = true



func _on_Hurtbox_roll_started():
	blinkAnimationPlayer.play("Stop")


func _on_Hurtbox_roll_ended():
	blinkAnimationPlayer.play("Stop")
