extends Node
#class_name SignalHub

signal onEvaluateRooms
signal onEnterRoom(roomName: String)
signal onLeaveRoom

signal onNewRoomTarget(roomName: String, time: float)
signal onNewScore(score: float)

# Called when the node enters the scene tree for the first time.
func _ready():
	onEnterRoom.connect(_onEnterRoom)
	onLeaveRoom.connect(_onLeaveRoom)
	pass # Replace with function body.

func _onEnterRoom(roomName: String):
	print("Player enters room ", roomName)
	
func _onLeaveRoom():
	print("Player leaves room")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
