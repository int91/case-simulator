extends Panel

onready var SkinsGrid = get_node("SkinsGrid")
onready var CTex = get_node("CaseTexture")
onready var CName = get_node("CaseTexture/CaseName")
onready var Amount = get_node("Amount")
onready var Keys = get_node("Keys")
onready var player = get_node("/root/World/Player")

var caseskins = []
var case = null
var index = null
var caseName = null

func _ready() -> void:
	pass

func createSkins(skins):
	for i in range(skins.size()):
		var spawnpath = SkinsGrid
		var instance = load("res://Skins/Skin.tscn")
		var skin = instance.instance()
		skin.loadSkin(skins[i])
		skin.InCase = true
		spawnpath.add_child(skin)
	pass

func createStickers(skins):
	for i in range(skins.size()):
		var spawnpath = SkinsGrid
		var instance = load("res://Skins/Sticker.tscn")
		var skin = instance.instance()
		skin.loadSkin(skins[i])
		skin.InCase = true
		spawnpath.add_child(skin)
	pass

func _process(_delta: float) -> void:
	if index != null:
		Amount.text = "Amount: " + str(player.cases[index].Amount)
		Keys.text = "Keys: " + str(player.cases[index].Keys)
		CName.text = caseName
		pass
	if Input.is_action_just_pressed("ui_cancel") && self.visible && !$"/root/World/Control/SkinOpened".visible:
		self.hide()
		pass
	pass

func _on_Button2_pressed() -> void:
	if player.cases[index].Amount > 0 && player.cases[index].Keys > 0:
		player.cases[index].Amount -= 1
		player.cases[index].Keys -= 1
		case.openCase()
		pass
	pass

func _on_CloseMenu_pressed() -> void:
	self.hide()
	pass
