extends Area2D
class_name Room

@export var roomName: String
var _playerInside: bool = false

func getPlayerInside():
	return _playerInside
	
func getName():
	return roomName

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is PlayerPawn:
		_playerInside = true
		SignalHub.onEvaluateRooms.emit()


func _on_body_exited(body):
	if body is PlayerPawn:
		_playerInside = false
		SignalHub.onEvaluateRooms.emit()
