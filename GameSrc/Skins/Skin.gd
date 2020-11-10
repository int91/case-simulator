extends TextureRect
onready var selectPanel = get_node("/root/World/Control/SkinSelected")
var Hovered = false
var skin = {
	"Gun":"Any",
	"Name":"Any itemDefault",
	"ID":"SkinDef",
	"Image":"Textures/NoSkin.png",
	"Rarity":"Exotic",
	"Float":0,
	"Condition":"",
	"Locked":false,
	"Values":[3000, 2000, 1000, 500, 250],
	"Value":0,
	"Opened":false,
	"Type":0,
	"Stickers":[],
	"Charm":{}
}
var inInv = false
var InCase = false
func _ready():
	self.texture = load(skin.Image)
	if skin.Locked:
		$Sprite.show()
	else:
		$Sprite.hide()
	pass
	if self.skin.Type == 0 && !inInv:
		match (skin.Condition):
			"Factory New":
				skin.Value = skin.Values[0]
				pass
			"Tested":
				skin.Value = skin.Values[1]
				pass
			"Used":
				skin.Value = skin.Values[2]
				pass
			"Heavily Worn":
				skin.Value = skin.Values[3]
				pass
			"Battle Scarred":
				skin.Value = skin.Values[4]
				pass
	elif self.skin.Type == 1 && !inInv:
		if self.skin.Opened:
			match (self.skin.Condition):
				"Factory New":
					skin.Value = skin.Values[0]
					pass
				"Tested":
					skin.Value = skin.Values[1]
					pass
				"Used":
					skin.Value = skin.Values[2]
					pass
				"Heavily Worn":
					skin.Value = skin.Values[3]
					pass
				"Battle Scarred":
					skin.Value = skin.Values[4]
					pass
		else:
			match (self.skin.Condition):
				"Factory New":
					skin.Value = skin.Values[0] * 1.5
					pass
				"Tested":
					skin.Value = skin.Values[1] * 1.5
					pass
				"Used":
					skin.Value = skin.Values[2] * 1.5
					pass
				"Heavily Worn":
					skin.Value = skin.Values[3] * 1.5
					pass
				"Battle Scarred":
					skin.Value = skin.Values[4] * 1.5
					pass
	elif self.skin.Type == 2 && !inInv:
		if self.skin.Opened:
			match (self.skin.Condition):
				"Factory New":
					skin.Value = skin.Values[0]
					pass
				"Tested":
					skin.Value = skin.Values[1]
					pass
				"Used":
					skin.Value = skin.Values[2]
					pass
				"Heavily Worn":
					skin.Value = skin.Values[3]
					pass
				"Battle Scarred":
					skin.Value = skin.Values[4]
					pass
		else:
			match (self.skin.Condition):
				"Factory New":
					skin.Value = skin.Values[0] * 1.5
					pass
				"Tested":
					skin.Value = skin.Values[1] * 1.5
					pass
				"Used":
					skin.Value = skin.Values[2] * 1.5
					pass
				"Heavily Worn":
					skin.Value = skin.Values[3] * 1.5
					pass
				"Battle Scarred":
					skin.Value = skin.Values[4] * 1.5
					pass
	pass
func sell():
	if !skin.Locked:
		selectPanel = get_node("/root/World/Control/SkinSelected")
		checkInvRemove()
		self.queue_free()
		selectPanel.hide()
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_leftclick") && Hovered &&!InCase && selectPanel.itemToEquip == null:
		var selectName = get_node("/root/World/Control/SkinSelected/SkinName")
		var selectStats = get_node("/root/World/Control/SkinSelected/SkinStats")
		selectPanel.raise()
		selectName.text = self.skin.Name
		if self.skin.Type == 0:
			selectStats.text = str("Rarity: " + str(self.skin.Rarity) + "\n" + "Float: " 
			+ str(self.skin.Float) + "\n" + "Condition: " + str(self.skin.Condition) + "\n" + "Stickers: " +
			 str(self.skin.Stickers) + "Charm: " +
			 str(self.skin.Charm) + "\n" + "Value: $" + str(self.skin.Value))
			pass
		elif self.skin.Type == 1:
			selectStats.text = str("Rarity: " + str(self.skin.Rarity) + "\n" + "Float: " 
			+ str(self.skin.Float) + "\n" + "Condition: " + str(self.skin.Condition) + "\n"
			+ "Value: $" + str(self.skin.Value))
			pass
		elif self.skin.Type == 2:
			selectStats.text = str("Rarity: " + str(self.skin.Rarity) + "\n" + "Float: " 
			+ str(self.skin.Float) + "\n" + "Condition: " + str(self.skin.Condition) + "\n"
			+ "Value: $" + str(self.skin.Value))
			pass
		selectPanel.skin = self
		selectPanel.show()
	if Input.is_action_just_pressed("ui_leftclick") && Hovered &&!InCase && selectPanel.itemToEquip != null:
		if self.skin.Type == 0 && selectPanel.itemToEquip != null:
			if selectPanel.itemToEquip.skin.Type == 1:
				applySticker(selectPanel.itemToEquip.skin)
				selectPanel.itemToEquip.queue_free()
				selectPanel.itemToEquip = null
				pass
			elif selectPanel.itemToEquip != null && selectPanel.itemToEquip.skin.Type == 2:
				applyCharm(selectPanel.itemToEquip.skin)
				selectPanel.itemToEquip.queue_free()
				selectPanel.itemToEquip = null
				pass
			pass
	if Input.is_action_just_pressed("ui_rightclick") && Hovered && !skin.Locked && Settings.GamblingSell &&!InCase:
		selectPanel = get_node("/root/World/Control/SkinSelected")
		#Make a gambling UI where you activate a boolean and turn on the gambling sell mode.
		checkInvRemoveGambling()
		self.queue_free()
		selectPanel.hide()
		pass
	if Input.is_action_just_pressed("tab") && Hovered &&!InCase:
		Hovered = false
		pass
	pass
func applySticker(sticker):
	if self.skin.Stickers.size() < 3:
		self.skin.Stickers.append(sticker)
		self.skin.Value += sticker.Value
		checkInvRemoveDirect(sticker)
		pass
	pass
func applyCharm(charm):
	if self.skin.Charm.size() < 1:
		self.skin.Charm = charm
		self.skin.Value += charm.Value
		checkInvRemoveDirect(charm)
		pass
	pass
func checkInvLock():
	var player = get_node("/root/World/Player")
	for i in range(player.inventory.size()):
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name && player.inventory[i].Condition == self.skin.Condition:
			player.inventory[i].Locked = !player.inventory[i].Locked
			if player.inventory[i].Locked:
				$Sprite.show()
			else:
				$Sprite.hide()
			pass
			break
		pass
	pass
func checkInvRemove():
	var player = get_node("/root/World/Player")
	for i in range(player.inventory.size()):
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name && player.inventory[i].Condition == self.skin.Condition && !player.inventory[i].Locked:
			player.money += self.skin.Value
			player.inventory.remove(i)
			player.addValue()
			break
		pass
	pass
func checkInvRemoveDirect(item):
	var player = get_node("/root/World/Player")
	for _i in range(player.inventory.size()):
		if player.inventory.find(item) >= 0:
			var Item = player.inventory.find(item)
			player.inventory.remove(Item)
			player.addValue()
			break
		pass
	pass
func checkInvRemoveGambling():
	var player = get_node("/root/World/Player")
	for i in range(player.inventory.size()):
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name && player.inventory[i].Condition == self.skin.Condition && !player.inventory[i].Locked:
			player.gamblingcoins += player.inventory[i].Value / 100
			player.inventory.remove(i)
			player.addValue()
			break
		pass
	pass
func loadSkin(skinID):
	var saveFile = File.new()
	saveFile.open("res://Skins/"+skinID+".json", File.READ)
	var skinData = parse_json(saveFile.get_line())
	saveFile.close()
	self.skin.Name = skinData.Name
	if skinData.has("Gun"):
		self.skin.Gun = skinData.Gun
	pass
	self.skin.Type = skinData.Type
	self.skin.Image = skinData.Image
	self.skin.Rarity = skinData.Rarity
	self.skin.Values = skinData.Values
	return skinData
	
func _on_Skin_mouse_entered():
	if !InCase:
		self.Hovered = true
		pass
	pass
func _on_Skin_mouse_exited():
	if !InCase:
		self.Hovered = false
		pass
	pass
