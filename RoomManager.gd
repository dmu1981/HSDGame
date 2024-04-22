extends Node

class_name RoomManager

@export var roomNode: Node

var _rooms : Dictionary
var _lastRoom = null

func pickRandomRoom():
	var randomIndex = floor(_rooms.keys().size() * randf())
	for key in _rooms.keys():
		if randomIndex == 0:
			return key
		else:
			randomIndex -= 1
		
	# You should never get here as randomIndex should reach 0 before this!
	printerr("pickRandomRoom is wrongly implemented, check logic!")
	return null
	

func _addRoom(room: Room):	
	var key = room.getName()
	if not _rooms.has(key):
		_rooms[key] = Array()
	
	_rooms[key].append(room)

func _enumerateRooms():
	for child in roomNode.get_children():
		print(child)
		if child is Room:
			_addRoom(child as Room)
			
	print("RoomManager found the following rooms in this level...")
	for roomName in _rooms.keys():
		print(roomName)
	print("----")

# Called when the node enters the scene tree for the first time.
func _ready():
	_enumerateRooms()
	SignalHub.onEvaluateRooms.connect(_onEvaluateRooms)
	pass # Replace with function body.

func _onEvaluateRooms():
	var insideRoom = null
	for roomName in _rooms.keys():
		for rooms in _rooms[roomName]:
			if rooms.getPlayerInside():
				if insideRoom == null or insideRoom == roomName:
					insideRoom = roomName
				else:
					printerr("Player inside two rooms at the same time: ", insideRoom, " and ", roomName)
					return
					
	if _lastRoom == insideRoom:
		# Do not emit a signal if room status hasn´t changed
		return
	
	_lastRoom = insideRoom
	if insideRoom == null:
		SignalHub.onLeaveRoom.emit()
	else:
		SignalHub.onEnterRoom.emit(insideRoom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
