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


func _on_DevConsole_text_entered(new_text: String) -> void:
	if "give" in self.text.to_lower():
		var p = $"/root/World/Player"
		for i in range(p.cases.size()):
			if p.cases[0] != null:
				p.cases[0].Amount = 1000
				p.cases[0].Keys = 1000
				print("Given!")
		pass
	pass
