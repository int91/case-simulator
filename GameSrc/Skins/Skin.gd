extends TextureRect
var Hovered = false
var skin = {
	"Gun":"Any",
	"Name":"Any SkinDefault",
	"ID":"SkinDef",
	"Image":"Textures/NoSkin.png",
	"Rarity":"Exotic",
	"Float":0,
	"Condition":"",
	"Locked":false,
	"Values":[3000, 2000, 1000, 500, 250],
	"Value":0,
}
func _ready():
	self.texture = load(skin.Image)
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
	if skin.Locked:
		$Sprite.show()
	else:
		$Sprite.hide()
	pass
	pass
func _process(delta):
	if Input.is_action_just_pressed("ui_leftclick") && Hovered:
		checkInvLock()
	if Input.is_action_just_pressed("ui_rightclick") && Hovered && !skin.Locked && !Settings.GamblingSell:
		var selectPanel = get_node("/root/World/Control/SkinSelected")
		var player = get_node("/root/World/Player")
		player.money += self.skin.Value
		checkInvRemove()
		self.queue_free()
		selectPanel.hide()
		pass
	if Input.is_action_just_pressed("ui_rightclick") && Hovered && !skin.Locked && Settings.GamblingSell:
		var selectPanel = get_node("/root/World/Control/SkinSelected")
		var player = get_node("/root/World/Player")
		#Make a gambling UI where you activate a boolean and turn on the gambling sell mode.
		checkInvRemoveGambling()
		self.queue_free()
		selectPanel.hide()
		pass
	if Input.is_action_just_pressed("tab") && Hovered:
		Hovered = false
		pass
	pass
func checkInvLock():
	var player = get_node("/root/World/Player")
	for i in range(player.inventory.size()):
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name:
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
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name:
			player.inventory.remove(i)
			break
		pass
	pass
func checkInvRemoveGambling():
	var player = get_node("/root/World/Player")
	for i in range(player.inventory.size()):
		if player.inventory[i].Float == self.skin.Float && player.inventory[i].Name == self.skin.Name:
			player.gamblingcoins = player.inventory[i].Value
			player.inventory.remove(i)
			break
		pass
	pass
func loadSkin(skinID):
	var saveFile = File.new()
	saveFile.open("res://Skins/"+skinID+".json", File.READ)
	var skinData = parse_json(saveFile.get_line())
	saveFile.close()
	self.skin.Name = skinData.Name
	self.skin.Gun = skinData.Gun
	self.skin.Image = skinData.Image
	self.skin.Rarity = skinData.Rarity
	self.skin.Values = skinData.Values
	return skinData
	
func _on_Skin_mouse_entered():
	Hovered = true
	var selectPanel = get_node("/root/World/Control/SkinSelected")
	var selectName = get_node("/root/World/Control/SkinSelected/SkinName")
	var selectStats = get_node("/root/World/Control/SkinSelected/SkinStats")
	selectPanel.show()
	selectName.text = self.skin.Name
	selectStats.text = str("Rarity: " + str(self.skin.Rarity) + "\n" + "Float: " 
	+ str(self.skin.Float) + "\n" + "Condition: " + str(self.skin.Condition) + "\n" + 
	"Value: $" + str(self.skin.Value))
	pass
func _on_Skin_mouse_exited():
	Hovered = false
	var selectPanel = get_node("/root/World/Control/SkinSelected")
	selectPanel.hide()
	pass
