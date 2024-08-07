extends Control

var _start_scene : PackedScene = load("res://scenes/start_menu.tscn")

func _on_button_pressed():
	#get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	get_tree().change_scene_to_packed(_start_scene)
