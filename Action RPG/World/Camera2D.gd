extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight
onready var world2Detection = $World2PlayerDetectionZone
onready var originalTopLeftY = -311.309
onready var originalTopLeftX = -1361.813
onready var originalTopRightY= 493
onready var originalTopRightX = 736
onready var zoomAnimation = $AnimationPlayer

# Distance to the target in pixels below which the camera slows down.
const SLOW_RADIUS := 300.0

# Maximum speed in pixels per second.
export var max_speed := 2000.0
# Mass to slow down the camera's movement
export var mass := 2.0

var _velocity = Vector2.ZERO
# Global position of an anchor area. If it's equal to `Vector2.ZERO`,
# the camera doesn't have an anchor point and follows its owner.
var _anchor_position := Vector2.ZERO

var _target_zoom = 4.0


func _ready():
	self.zoom.x = 1
	self.zoom.y = 1
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x
	
	
func transition_boss():
	zoomAnimation.play("CameraZoomOut")
	topLeft.position.y = 128
	topLeft.position.x =  768
	bottomRight.position.y = bottomRight.position.y
	bottomRight.position.x = bottomRight.position.x
	
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x
		
func transition_world1():
	limit_top = originalTopLeftY
	limit_left = originalTopLeftX
	limit_bottom = originalTopRightY
	limit_right = originalTopRightX
	
	
# Smoothly update the zoom level using a linear interpolation.
func update_zoom() -> void:
	if not is_equal_approx(zoom.x, _target_zoom):
		# The weight we use considers the delta value to make the animation frame-rate independent.
		var new_zoom_level: float = lerp(
			zoom.x, _target_zoom, 1.0 - pow(0.008, get_physics_process_delta_time())
		)
		zoom = Vector2(new_zoom_level, new_zoom_level)

# Gradually steers the camera to the `target_position` using the arrive steering behavior.
func arrive_to(target_position: Vector2) -> void:
	var distance_to_target := position.distance_to(target_position)
	# We approach the `target_position` at maximum speed, taking the zoom into account, until we
	# get close to the target point.
	var desired_velocity := (target_position - position).normalized() * max_speed * zoom.x
	# If we're close enough to the target, we gradually slow down the camera.
	if distance_to_target < SLOW_RADIUS * zoom.x:
		_velocity *= (distance_to_target / (SLOW_RADIUS * zoom.x))

	_velocity += (desired_velocity - _velocity) / mass
	position += _velocity * get_physics_process_delta_time()


#func _on_World2PlayerDetectionZone_body_entered(body):
	#transition_world2()
	


#func _on_World1PlayerDetectionZone2_body_entered(body):
	#transition_world1()


#func _on_World2PlayerDetectionZone_body_entered(body):
#	transition_world2()


func _on_World1PlayerDetectionZone2_body_entered(body):
	transition_world1()


func _on_PlayerDetectionZone_body_entered(body):
	#update_zoom()

	transition_boss()
