extends Spatial

var timer = null
var gameTime = 0

export var intervalArray = [ 0, 15, 25, 35, 45, 55, 65, 75, 85, 95 ]
var player = null

# Time vars
var time = 0
var time_mult = 1.0

signal changeScore

func _ready():
	get_tree().paused = false
	player = utils.get_main_node().get_node("Fish")
	player.connect("playerDead", self, "onPlayerDead")
	
	#Timer
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(1.0)
	timer.connect("timeout", self, "onTimerTimeout")
	timer.start()
	add_child(timer)

	pass

func onPlayerDead():
	print("[GameRoot] Fish dead.")
	
	var gameover = preload("res://Scenes/HUD/ContainerGameover.tscn").instance()
	get_node("hud").add_child(gameover)
	pass

func onTimerTimeout():
	#gameTime = gameTime + 1
	#print(gameTime)

	#if (gameTime <= 15):
	#	player.speed = player.speed + 10
	#	pass
		
	global.setPlayerScore(1)
	emit_signal("changeScore")
	
func _physics_process(delta):
	time += delta * time_mult
	
	if (time <= 5):
		player.speed = player.originSpeed + intervalArray[0]
	elif (time  >= 5 and time <= 10):
		player.speed = player.originSpeed + intervalArray[1]
	elif (time  >= 10 and time <= 15):
		player.speed = player.originSpeed + intervalArray[2]
	elif (time  >= 20 and time <= 25):
		player.speed = player.originSpeed + intervalArray[3]
	elif (time  >= 25 and time <= 30):
		player.speed = player.originSpeed + intervalArray[4]
	elif (time  >= 30 and time <= 35):
		player.speed = player.originSpeed + intervalArray[5]
	elif (time  >= 35 and time <= 40):
		player.speed = player.originSpeed + intervalArray[4]
	elif (time  >= 40 and time <= 45):
		player.speed = player.originSpeed + intervalArray[3]
	elif (time  >= 45 and time <= 50):
		player.speed = player.originSpeed + intervalArray[5]
	elif (time  >= 50 and time <= 55):
		player.speed = player.originSpeed + intervalArray[6]
	elif (time  >= 55 and time <= 60):
		player.speed = player.originSpeed + intervalArray[7]
	elif (time  >= 60 and time <= 65):
		player.speed = player.originSpeed + intervalArray[6]		
	elif (time  >= 65):
		player.speed = player.originSpeed + intervalArray[9]
		pass