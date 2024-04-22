extends Node

@export var roomManager : RoomManager
@onready var questTimer : Timer = $"NewRoomTimer"

var _currentRoomTarget = null
var _currentRoom = null
var _correctRoom : bool = false

var _totalScore = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	# At the start of the game, wait 2.5 seconds
	questTimer.start(2.5)
	
	# Connect to the signals
	SignalHub.onEnterRoom.connect(_onEnterRoom)
	SignalHub.onLeaveRoom.connect(_onLeaveRoom)

func _onEnterRoom(room: String):
	_currentRoom = room
	if room == _currentRoomTarget:
		_correctRoom = true
		Engine.time_scale = 4.0
	else:
		_correctRoom = false
		Engine.time_scale = 1.0
		
func _onLeaveRoom():
	_currentRoom = null
	_correctRoom = false
	Engine.time_scale = 1.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _correctRoom:
		_totalScore += delta
		
	pass

func _on_timer_timeout():
	# Pick a new(!) random target room
	_currentRoomTarget = roomManager.pickRandomRoom()
	while _currentRoomTarget == _currentRoom:
		_currentRoomTarget = roomManager.pickRandomRoom()
	
	_correctRoom = false
	Engine.time_scale = 1.0
	
	# Pick a random time for this quest
	var time = randf_range(15.0, 25.0)
	
	# And emit the signal so the UI can display it properly
	SignalHub.onNewRoomTarget.emit(_currentRoomTarget, time)
	print("newRoom: ", _currentRoomTarget)
	
	# Start the timer
	questTimer.start(time)


func _on_announce_score_timer_timeout():
	SignalHub.onNewScore.emit(_totalScore)
	print("newScore:", _totalScore)
