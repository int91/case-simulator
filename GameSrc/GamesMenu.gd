extends VBoxContainer

var Panels = ["../CoinFlip", "../Tower"]

func setPanel(index):
	for i in range(Panels.size()):
		if i != index:
			var pa = get_node(Panels[i])
			pa.hide()
			pass
		else:
			var pa = get_node(Panels[index])
			pa.show()
			pass
	pass


func _on_CoinFlipbtn_pressed() -> void:
	setPanel(0)
	pass


func _on_Towerbtn_pressed() -> void:
	setPanel(1)
	pass
