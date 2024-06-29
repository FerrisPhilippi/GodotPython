extends Node

func send(_msg):
	PythonConnector.send()

func _on_button_pressed() -> void:
	send($LineEdit.text)
