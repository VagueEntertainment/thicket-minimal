extends Node
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	create_folders()
	get_update()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_folders():
	var dir = Directory.new()
	if !dir.dir_exists("user://cache"):
		dir.make_dir("user://cache")
	if !dir.dir_exists("user://favorites"):
		dir.make_dir("user://favorites")
	if !dir.dir_exists("user://database"):
		dir.make_dir("user://database")
	if !dir.dir_exists("user://games"):
		dir.make_dir("user://games")
	if !dir.dir_exists("user://updates"):
		dir.make_dir("user://updates")
		
func load_thicket():
	
	var loaded = ProjectSettings.load_resource_pack("user://updates/Thicket.pck")
	if loaded:
		var mw = ResourceLoader.load("res://MainWindow.tscn")
		var make_window = mw.instance()
		ProjectSettings.set_setting("display/window/size/height",make_window.HEIGHT)
		ProjectSettings.set_setting("display/window/size/width",make_window.WIDTH)
		add_child(make_window)
		OS.set_window_size(Vector2(make_window.HEIGHT,make_window.WIDTH))
		OS.set_window_always_on_top(false)
		OS.set_borderless_window(false)

func get_update():
	$HTTPRequest.set_download_file("user://updates/Thicket.pck")
	var headers = [
			"User-Agent: Pirulo/1.0 (Godot)",
			"Accept: */*"
		]
	$HTTPRequest.request("http://142.93.27.131:8675/thicket/Thicket.pck",headers,false,HTTPClient.METHOD_GET)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		load_thicket()

