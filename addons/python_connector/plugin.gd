@tool
extends EditorPlugin


func _enter_tree() -> void:
	if not Engine.has_singleton("PythonConnector"):
		var script = "res://addons/python_connector/python_connector.gd"
		if script:
			add_autoload_singleton("PythonConnector", script)
		else:
			print("Failed to load PythonConnector script.")
	else:
		print("PythonConnector autoload already exists.")
