#script: SpawnerWalls

extends Spatial

#const scn_walls = preload("res://Scenes/Wall_1.tscn")
const scn_floor = preload("res://Scenes/Floor.tscn")

const WALL_WIDTH = 300
const AMOUNT_TO_FILL_VIEW = 2

var wallArray = [ preload("res://Scenes/Walls/WallEasy1.tscn"), 
	preload("res://Scenes/Walls/WallEasy2.tscn"), 
	preload("res://Scenes/Walls/WallEasy3.tscn"),
	preload("res://Scenes/Walls/WallMedium1.tscn"),
	preload("res://Scenes/Walls/WallMedium2.tscn"),
	preload("res://Scenes/Walls/WallMedium3.tscn"),
	preload("res://Scenes/Walls/WallHard1.tscn"),
	preload("res://Scenes/Walls/WallHard2.tscn"),
	preload("res://Scenes/Walls/WallHard3.tscn") ]

var wallData = [ ]
var floorData = [ ]

#warning-ignore:unused_class_variable
onready var container = get_node("Container")

func _ready():
	#Spawn "start walls"
	var startWall = preload("res://Scenes/Walls/Wall.tscn").instance()
	wallData.append(startWall)
	get_node("Container").add_child(startWall)
	
	var new_floor = scn_floor.instance()
	floorData.append(new_floor)
	
	new_floor.set_transform(get_transform())
	#new_walls.transform(transform)
	new_floor.connect("destroyed", self, "go_next_floor")
	get_node("ContainerFloor").add_child(new_floor)
	
	#Random pozostałe 2 mapy
#warning-ignore:unused_variable
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
		#spawn_floor()
	pass

func spawn_and_move():
	spawn_walls()
	spawn_floor()
	pass

func spawn_walls():
	#print(wallArray[randi() % 2])
	var tempPosition = Vector3(0, 0, 0)
	var lastElement = null
	
	if not wallData.empty():
		lastElement = wallData.back()
	
	if lastElement:
		#print(lastElement.translation)
		tempPosition = lastElement.translation
	#print(lastElement)
	
	if lastElement == null:
		#lastElement.translation = translation
		#print(tempPosition)
		#print("null")
		pass
	
	#print(wallData.count())
	var new_walls = wallArray[randi() % 9].instance()
	wallData.append(new_walls)
	#print(i)
	#print(wallData)
	#print(new_walls.translation)
	#new_walls.set_transform(get_transform())
	new_walls.set_transform(get_transform())
	#new_walls.transform(transform)
	#new_walls.connect("destroyed", self, "go_next")
	new_walls.translation = translation + Vector3(WALL_WIDTH, 0, 0) + tempPosition
	get_node("Container").add_child(new_walls)
	
	#new_walls.translation = translation + Vector3(WALL_WIDTH, 0, 0)
	#new_walls.translation = translation + Vector3(WALL_WIDTH, 0, 0) + tempPosition
	pass

func spawn_floor():
	var tempPosition = Vector3(0, 0, 0)
	var lastElement = null
	
	if not floorData.empty():
		lastElement = floorData.back()
	
	if lastElement:
		tempPosition = lastElement.translation
	
	if lastElement == null:
		pass
		
	var new_floor = scn_floor.instance()
	floorData.append(new_floor)
	
	new_floor.set_transform(get_transform())
	#new_walls.transform(transform)
	new_floor.connect("destroyed", self, "go_next_floor")
	new_floor.translation = translation + Vector3(WALL_WIDTH, 0, 0) + tempPosition
	get_node("ContainerFloor").add_child(new_floor)
	
	#new_floor.translation = translation + Vector3(WALL_WIDTH, 0, 0) + tempPosition
	pass

func go_next_floor(object):
	print("Spawn next floor")
	if object != floorData.back() and object != floorData.front():
		var obj = floorData.front()
		obj.queue_free()
		floorData.remove(0)
		
		spawn_and_move()
	pass
	
func go_next(object):
	#print(object)
	# jeżeli jest na środku dodaj
	if object != wallData.back() and object != wallData.front():
		var obj = wallData.front()
		obj.queue_free()
		#print(wallData)
		wallData.remove(0)
		#wallData[0] = wallData[1]
		#wallData[1] = wallData[2]
		
		#print(wallData)
		#spawn new object
		spawn_and_move()
	pass