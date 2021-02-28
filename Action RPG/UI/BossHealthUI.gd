extends Control

var hearts = 21 setget set_boss_hearts
var max_hearts = 21 setget set_max_boss_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_boss_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	
func set_max_boss_hearts(value):
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
	#connect("add")
	self.max_hearts = PlayerStats.boss_max_health
	self.hearts = PlayerStats.boss_health
	PlayerStats.connect("boss_health_changed", self, "set_boss_hearts")
	PlayerStats.connect("boss_max_health_changed", self, "set_max_boss_hearts")
	PlayerStats.connect("checkpoint", self, "set_boss_hearts")
