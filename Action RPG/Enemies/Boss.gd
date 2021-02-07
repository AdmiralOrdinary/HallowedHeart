extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const CorruptedHeart = preload("res://World/CorruptedHeart.tscn")

export var ACCELERATION = 150
export var MAX_SPEED = 25
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE
	ATTACKMID,
	ATTACKLEFT,
	ATTACKRIGHT,
	SUMMON,
	BREAK
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = IDLE

onready var bossAnimationPlayer = $BossAnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var nearplayerDetectionZone = $NearPlayerDetectionZone
onready var leftplayerDetectionZone = $LeftPlayerDetectionZone
onready var rightplayerDetectionZone = $RightPlayerDetectionZone
onready var nearHitbox = $MidHitbox
onready var leftHitbox = $LeftHitbox
onready var rightHitbox = $RightHitbox
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
#onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var bat1health = $SuperBat1/Stats
onready var bat2health = $SuperBat2/Stats
onready var bat3health = $SuperBat3/Stats
onready var bat4health = $SuperBat4/Stats
onready var timer = $Timer


func _ready():
	animationTree.active = true
	state = IDLE #pick_random_state([ATTACKLEFT, ATTACKMID, ATTACKRIGHT])
	timer.start()
	PlayerStats.connect("boss_no_health", self, "_on_Stats_no_health")
	stats.set_process(false)

func _physics_process(delta):	
	match state:
		IDLE:
			#print("idle")
			animationState.travel("Idle")
			#print("timer start")
			#timer.set_one_shot(false)
			
			
			
			
			#if wanderController.get_time_left() == 0:
			#	update_wander()
			
		BREAK:
			hurtbox.start_invincibility(.5)
			animationState.travel("Injured")
			timer.stop()
			
		ATTACKMID:
			#print("all")
			animationState.travel("MidAttack")
			
			
		ATTACKLEFT:
			#print("left")
			animationState.travel("LeftAttack")
			
			#var player = playerDetectionZone.player
			
		ATTACKRIGHT:
			#print("right")
			animationState.travel("RightAttack")
			#rightHitbox.disabled = 2
			
			#var player = playerDetectionZone.player
			
		SUMMON:
			animationState.travel("Summon")
			timer.autostart = false
			
			#print("summon")
			
			#var player = playerDetectionZone.player
			
			
#func accelerate_towards_point(point, delta):
	#var direction = global_position.direction_to(point)
	#velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	#sprite.flip_h = velocity.x < 0

func seek_player():
	animationState.travel("Idle")
	#print(state)
	var random = rand_range(1,100)
	#print(random)
	if random <= 5:
		#print("1")
		#bat1health.set_health(2)
		#bat2health.set_health(2)
		#bat3health.set_health(2)
		#bat4health.set_health(2)
		state = SUMMON
	elif random <= 10:
		#print("2")
		state = IDLE
	if random <= 40:
		#print("3")
		if nearplayerDetectionZone.can_see_player():
			#print("Should print mid next")
			state = ATTACKMID
		elif leftplayerDetectionZone.can_see_player():
			#print("Should print left next")
			state = ATTACKLEFT
		elif rightplayerDetectionZone.can_see_player():
			#print("Should print right next")
			state = ATTACKRIGHT
		else:
			#print("Should print summon next")
			bat1health.set_health(2)
			bat2health.set_health(2)
			bat3health.set_health(2)
			bat4health.set_health(2)
			state = SUMMON
	elif random <= 65:
		#print("4")
		state = ATTACKRIGHT
	elif random <= 90:
		#print("5")
		state = ATTACKLEFT
	elif random <= 100:
		#print("6")
		state = ATTACKMID
	else:
		state = IDLE
		
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func create_smallheart():
		var world = get_tree().current_scene
		var corruptedHeart = CorruptedHeart.instance()
		get_parent().add_child(corruptedHeart)
		corruptedHeart.set_global_position(self.get_global_position())

func _on_Hurtbox_area_entered(area):
	PlayerStats.damageDone += 1
	PlayerStats.boss_health -= area.damage
	stats.health_count -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox._create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	PlayerStats.kills += 1
	create_smallheart()
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")

func _on_Animation_finished():
	timer.start()
	print("timer start")
	state = IDLE
	

func _on_Timer_timeout():
	timer.stop()
	print("timer Stop")
	if nearplayerDetectionZone.can_see_player():
		#print("Should print mid next")
		seek_player()
	elif leftplayerDetectionZone.can_see_player():
		#print("Should print left next")
		seek_player()
	elif rightplayerDetectionZone.can_see_player():
		#print("Should print right next")
		seek_player()
	else:
		state = IDLE

func _on_Stats_health_count():
	
	print("HEALTH COUNT SIGNAL")
	state = BREAK
	stats.set_health_count(6)
