extends Panel

var skin
var itemToEquip

func _ready():
	pass
func _process(delta):
	if skin != null:
		$SellBtn.text = "Sell: $" + str(skin.skin.Value)
		if !skin.skin.Locked:
			$LockSkinBtn.text = "Lock"
			$SellBtn.show()
		else:
			$LockSkinBtn.text = "Unlock"
			$SellBtn.hide()
		if skin.skin.Type == 0:
			$ApplyBtn.hide()
		else:
			$ApplyBtn.show()
	if Input.is_action_just_pressed("ui_cancel") && self.visible:
		self.hide()
	pass
func _on_CloseMenu_pressed():
	self.hide()
	pass


func _on_SellBtn_pressed() -> void:
	skin.sell()
	skin = null
	pass


func _on_LockSkinBtn_pressed() -> void:
	skin.checkInvLock()
	pass


func _on_LockSkinBtn2_pressed() -> void:
	self.hide()
	pass


func _on_ApplyBtn_pressed() -> void:
	itemToEquip = skin
	skin = null
	print(str(itemToEquip))
	#Show a UI that says "Select a gun you would like to apply this Skin / Sticker to"
	self.hide()
	pass
