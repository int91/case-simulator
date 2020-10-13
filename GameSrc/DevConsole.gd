extends LineEdit

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("console"):
		if self.visible:
			self.hide()
			self.clear()
		else:
			self.show()
			self.grab_focus()
	pass
