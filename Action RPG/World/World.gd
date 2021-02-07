extends Node2D

onready var WorldMusicPlayer = $WorldMusicPlayer
onready var BossMusicPlayer = $BossMusicPlayer
onready var bossHealthUI = $UI/BossHealthUI
onready var tween_out = get_node("Tween")
onready var bossRoomEnteredExitPrevention = $PlayerDetectionZone/StaticBody2D/CollisionShape2D
onready var bossRoomEnteredCameraChange = $PlayerDetectionZone/CollisionShape2D
onready var pauseMenuCheckpoint = $UI/PauseMenu
onready var player = $YSort/Player

export var transition_duration = 2.00
export var transition_type = 1 # TRANS_SINE

#var time_start = 0
#var time_now = 0

func _ready():
	WorldMusicPlayer.play()
	#time_start = OS.get_unix_time()
	set_process(true)
	PlayerStats.connect("boss_no_health", self, "_on_Stats_no_health")
	PlayerStats.connect("checkpoint", self, "checkpoint")

func checkpoint():
	player.set_position(Vector2(821, 150))
	
func _process(delta):
	#time_now = OS.get_unix_time()
	#var elapsed = time_now - time_start
	#var minutes = elapsed / 60
	#var seconds = elapsed % 60
	#var str_elapsed = "%02d : %02d" % [minutes, seconds]
	#print("elapsed : ", str_elapsed)
	pass

func _on_WorldMusicPlayer_finished():
	WorldMusicPlayer.play()


func _on_PlayerDetectionZone_body_entered(body):
	PlayerStats.checkpoint = true
	PlayerStats.set_checkpoint()
	bossHealthUI.visible = true
	fade_out(WorldMusicPlayer)
	fade_in(BossMusicPlayer)
	BossMusicPlayer.play()
	bossRoomEnteredExitPrevention.set_deferred("disabled", false)
	bossRoomEnteredCameraChange.set_deferred("disabled", true)


func _on_BossMusicPlayer_finished():
	BossMusicPlayer.play()
	

func fade_out(stream_player):
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped
	
func fade_in(stream_player):
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", -80, 0, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped

func _on_TweenOut_tween_completed(object, key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()
	
func _on_Stats_no_health():
	fade_out(BossMusicPlayer)
	
	
