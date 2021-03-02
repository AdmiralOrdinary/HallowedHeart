extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var richTextLabel = $RichTextLabel
onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty
onready	var timeLabel = $Label
var ms = 0
var s = 0
var m = 0
var timerText

func _process(delta):
	if ms > 9:
		s+=1
		ms=0
		
	if s > 59:
		m+=1
		s=0
		
	timerText = "%02d : %02d : %02d" % [m, s, ms]
	richTextLabel.set_text(timerText)
	PlayerStats.elapsed = timerText
	PlayerStats.timeMinutes = m
	PlayerStats.timeSeconds = s
	PlayerStats.timeMiliseconds = ms
	#timeLabel.text = "Time: " + PlayerStats.elapsed

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15
		
func add_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15
	
func _ready():
	m = PlayerStats.timeMinutes
	s = PlayerStats.timeSeconds
	ms = PlayerStats.timeMiliseconds
	richTextLabel.set_text(PlayerStats.elapsed)
	#connect("add")
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")


func _on_Timer_timeout():
	ms += 1
