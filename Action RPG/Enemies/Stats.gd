extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
var damage = 1
var boss_health = 21 setget set_boss_health
var boss_max_health = 21 setget set_boss_max_health
var health_count = 8  setget set_health_count
var checkpoint_max_health
var checkpoint_health
var checkpoint_damage
var checkpoint = false
var playerStartPosition_X = 0 setget set_player_start_position_X
var PlayerStartPosition_Y = 0 setget set_player_start_position_Y

# Keep track of player progess and stats
var str_elapsed
#var time_start = 0
#var time_now = 0
var restarts = 0
var kills = 0
var hearts = 0
var deaths = 0
var damageDone = 0
var rolls = 0
var damageTaken = 0
var elapsed = "00:00:00"
var minutes = 0
var seconds = 0
var timeMinutes = 0
var timeSeconds = 0
var timeMiliseconds = 0
var upgrades = 0

signal health_count
signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal boss_health_changed(value)
signal boss_health_count_changed(value)
signal boss_max_health_changed(value)
signal damage_change(value)
signal boss_no_health
signal checkpoint
#signal add_max_health(value)

func _process(delta):
	#time_now = OS.get_unix_time()
	#elapsed = time_now - time_start
	#minutes = elapsed / 60
	#str_elapsed = "%02d : %02d" % [minutes, seconds]
	#print("elapsed : ", str_elapsed)
	pass
	
func _ready():
	#time_start = OS.get_unix_time()
	#set_process(true)
	self.health = max_health
	self.boss_health = boss_max_health
	
func set_player_start_position_X(value):
	playerStartPosition_X = value

func set_player_start_position_Y(value):
	PlayerStartPosition_Y = value 
	
func checkpoint():
	emit_signal("checkpoint")
	set_player_start_position_X(800)
	set_player_start_position_Y(360)
	set_health(checkpoint_health)
	set_max_health(checkpoint_max_health)
	set_damage(checkpoint_damage)
	
func set_checkpoint():
	checkpoint_health = health
	checkpoint_max_health = max_health
	checkpoint_damage = damage

func main_menu():
	timeMinutes = 0
	timeSeconds = 0
	timeMiliseconds = 0
	elapsed = "00:00:00"
	#time_now = time_start
	#minutes = elapsed / 60
	#seconds = elapsed % 60
	#str_elapsed = "%02d : %02d" % [minutes, seconds]
	restarts = 0
	kills = 0
	hearts = 0
	deaths = 0
	damageDone = 0
	rolls = 0
	damageTaken = 0
	reset_player_health()
	reset_boss_health()

func reset_player_health():
	max_health = 4
	health = 4
	
func reset_boss_health():
	boss_max_health = 21
	boss_health = 21

func add_health(value):
	if health < max_health:
		hearts += 1
		health += value
		emit_signal("health_changed",health)
	else:
		pass
		
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)
	
func add_max_health(value):
	upgrades += 1
	#emit_signal("add_max_health", 1)
	max_health += value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed",health)
	if health <= 0:
		emit_signal("no_health")
		
func add_damage(value):
	upgrades += 1
	damage += value
	emit_signal("damage_change", value)

func set_damage(value):
	damage = value
	emit_signal("damage_set", value)

func set_boss_health(value):
	boss_health = value
	emit_signal("boss_health_changed",boss_health)
	if boss_health <= 0:
		emit_signal("boss_no_health")
		
func set_health_count(value):
	health_count = value
	emit_signal("boss_health_count_changed",health_count)
	if health_count <= 0:
		emit_signal("health_count")
		
func set_boss_max_health(value):
	boss_max_health = value
	self.health = min(boss_health, boss_max_health)
	emit_signal("boss_max_health_changed", boss_max_health)

