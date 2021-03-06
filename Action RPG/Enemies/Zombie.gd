extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const SmallHeart = preload("res://World/SmallHeart.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = IDLE



onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var attackController = $AttackController
onready var animationPlayer = $AnimationPlayer
onready var attackAnimationPlayer = $AttackAnimationPlayer
onready var hitbox = $Hitbox
onready var collision = $CollisionShape2D
onready var hitcoll = $Hitbox/CollisionShape2D
onready var hurtcoll = $Hurtbox/CollisionShape2D

func _ready():
	state = pick_random_state([IDLE, WANDER])
	stats.set_process(false)
	#animationPlayer.play("Stop")
	#self.visible = false
	#hurtcoll.set_deferred("disabled", true)
	#hitcoll.set_deferred("disabled", true)
	#collision.set_deferred("disabled", true)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 350 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			#animationPlayer.play("Stop")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
			
		WANDER:
			#animationPlayer.play("Stop")
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				#jump_towards_point(player.global_position,delta)
				#animationPlayer.play("Attack")
				state = ATTACK
			else:
				#animationPlayer.play("Stop")
				state = IDLE
				
		ATTACK:
			var player = playerDetectionZone.player
			if player != null:
				#jump_towards_point(player.global_position,delta)
				attackAnimationPlayer.play("Attack")

			else:
				attackAnimationPlayer.play("Stop")
				#animationPlayer.play("Stop")
				state = IDLE
			

				
				
			if softCollision.is_colliding():
				velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
			
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))
	
func update_attack():
	#state = pick_random_state([IDLE, WANDER])
	attackController.start_wander_timer(3)

func accelerate_towards_point(point, delta):
	#animationPlayer.play("Attack")
	var direction = global_position.direction_to(point)
	#velocity = velocity.move_toward(direction * MAX_SPEED*5, ACCELERATION*5 * delta)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	#velocity = velocity.move_toward(direction * MAX_SPEED/5, ACCELERATION/5 * delta)
	sprite.flip_h = velocity.x < 0


func stop_moving(delta):
	velocity = Vector2.ZERO
	
func jump_towards_point(delta):
	#velocity = velocity.move_toward(0 * 0, 0 * delta)
	#animationPlayer.play("Stop")
	var player = playerDetectionZone.player
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED*2, ACCELERATION*2 * delta)
	#velocity = velocity.move_toward(direction * MAX_SPEED/5, ACCELERATION/5 * delta)
		sprite.flip_h = velocity.x < 0
	#animationPlayer.play("Stop")
	else:
		attackAnimationPlayer.play("Stop")

func seek_player():
	if playerDetectionZone.can_see_player():
		state = ATTACK
	else:
		pick_random_state([IDLE, WANDER])
		
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func create_smallheart():
	if PlayerStats.health != PlayerStats.max_health:
		if rand_range(0, 100) <= 25:
			var world = get_tree().current_scene
			var smallHeart = SmallHeart.instance()
			get_parent().add_child(smallHeart)
			smallHeart.set_global_position(self.get_global_position())
		else:
			pass
	else:
		pass

func _on_Hurtbox_area_entered(area):
	PlayerStats.damageDone += 1
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox._create_hit_effect()
	hurtbox.start_invincibility(0.6)

func _on_Stats_no_health():
	PlayerStats.kills += 1
	create_smallheart()
	#stats.set_health(2)
	queue_free()
	#self.visible = false
	#hitbox.set_deferred("monitoring", false)
	#hitbox.set_deferred("monitorable", false)
	#hurtbox.set_deferred("monitorable", false)
	#hurtbox.set_deferred("monitoring", false)
	#collision.set_deferred("disabled", true)
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")
	attackAnimationPlayer.stop(false)

func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
	attackAnimationPlayer.play()
