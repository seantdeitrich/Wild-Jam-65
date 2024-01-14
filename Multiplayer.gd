extends Control


#Setup peer connection
var peer = ENetMultiplayerPeer.new()

var brobot = preload("res://Brobot.tscn")

@export var Address: String = "127.0.0.1"
@export var Port: int = 7777

@rpc("any_peer","call_local")

#Create a server on button press
func _on_host_pressed() -> void:

	#Create server on port var: Port with 2 players
	peer.create_server(Port, 2)
	multiplayer.set_multiplayer_peer(peer)

	#Connect and call a function to add the player to the scene tree
	multiplayer.peer_connected.connect(add_player)

#Join another session
func _on_join_pressed() -> void:

	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, Port)
	multiplayer.set_multiplayer_peer(peer)


#Create a player with name player id
func add_player(id):

	#Instantiate an instance of brobot as another player
	#CHANGE TO DRUID
	var player = brobot.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
