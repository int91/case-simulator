extends Panel

func _ready():
	pass
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") && self.visible:
		self.hide()
	pass
func _on_CloseMenu_pressed():
	self.hide()
	pass
