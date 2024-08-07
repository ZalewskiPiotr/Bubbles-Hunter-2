extends Control

var _help_scene : PackedScene = load("res://scenes/help_menu.tscn")
var _main_scene : PackedScene = load("res://scenes/main_node.tscn")


func _on_button_play_pressed():
	#get_tree().change_scene_to_file("res://scenes/main_node.tscn")
	get_tree().change_scene_to_packed(_main_scene)


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_help_pressed():
	#get_tree().change_scene_to_file("res://scenes/help_menu.tscn")
	get_tree().change_scene_to_packed(_help_scene)
