extends Node

var client = WebSocketPeer.new()
var url = "ws://localhost:6000"
 

func _ready() -> void:
	var path = ProjectSettings.globalize_path("res://addons/python_connector/ws.py")
	var pystdout = []
	#OS.execute("python", [path], pystdout, true)
	
	var err = client.connect_to_url(url)
	print(err)
	if err != 0:
		set_process(false)
		print("Unable to connect!")

func _process(_delta: float) -> void:
	client.poll()
	var state = client.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while client.get_available_packet_count():
			print("Got message form server: " + str(client.get_packet().get_string_from_utf8()))
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = client.get_close_code()
		var reason = client.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.

func send(msg: Dictionary = {"action": "lappi", "kacka": 3}):
	client.send(JSON.stringify(msg).to_utf8_buffer())

func _on_button_pressed() -> void:
	send($LineEdit.text)
