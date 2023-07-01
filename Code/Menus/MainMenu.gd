extends Control


func _on_find_game_pressed():
	$Tabs.changeTab(2)

func _on_settings_pressed():
	$Tabs.changeTab(1)

func _on_quit_pressed():
	get_tree().quit()

func _on_username_text_changed(new_text):
	Settings.playerName = new_text

func _on_back_pressed():
	$Tabs.changeTab(0)

func _on_button_pressed():
	$Tabs.changeTab(0)
