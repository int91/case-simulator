extends TextureButton

onready var cMenu = $"/root/World/Control"
onready var cSelect = $"../../../CaseSelected"
onready var skinOpen = $"../../../SkinOpened"
onready var skinName = $"../../../SkinOpened/SkinName"
onready var skinStats = $"../../../SkinOpened/SkinStats"
onready var skinText = $"../../../SkinOpened/SkinTexture"
onready var player = $"../../../../Player"
onready var world = get_node("/root") 
onready var nameNode = $CaseName
onready var caseAmount = $CaseAmount
var ID = "OACase"
var index = 0
var unlockLevel = 0
var caseName = "Operation Alpha"
var odds = [70, 33, 15, 7, 2]
var commonSkins = ["SkinDef"]
var uncommonSkins = ["UmpPHaze"]
var rareSkins = ["UmpBHaze"]
var exoticSkins = ["G18DeadWeight"]
var relicSkins = ["BayonetPHaze"]
var totalSkins = 0
var conditions = [0.23, 0.54, 0.73, 0.89, 1]
var isPreorder = false
var type = 0 #0 = Skins, 1 = Stickers, 2 = Charms
func _ready():
	totalSkins = commonSkins.size() + uncommonSkins.size() + rareSkins.size() + exoticSkins.size()
	if totalSkins > 25:
		push_error(caseName + " Case has too many non-relic skins, please change the amount of skins in the case.")
		pass
	nameNode.text = caseName
	pass
func _physics_process(_delta):
	if player.level >= unlockLevel:
		self.show()
		pass
	$CaseName.text = caseName + "\nCase"
	$CaseAmount.text = "X" + str(player.cases[index].Amount)
	pass
func loadCase(caseID):
	var saveFile = File.new()
	saveFile.open("res://Cases/"+caseID, File.READ)
	var caseData = parse_json(saveFile.get_line())
	saveFile.close()
	self.caseName = caseData.CaseName
	self.commonSkins = caseData.CommonSkins
	self.uncommonSkins = caseData.UncommonSkins
	self.rareSkins = caseData.RareSkins
	self.exoticSkins = caseData.ExoticSkins
	self.relicSkins = caseData.RelicSkins
	self.unlockLevel = caseData.UnlockLevel
	self.isPreorder = caseData.Preorder
	self.type = caseData.Type
	pass
func openCase():
	var skinType = int(rand_range(0, 100))
	var skinIndex
	var instance
	var skin
	instance = load("Skins/Skin.tscn")
	skin = instance.instance()
	if skinType <= odds[0]:
		skinIndex = int(rand_range(0, commonSkins.size()))
		skin.loadSkin(commonSkins[skinIndex])
	else:
		skinType -= odds[0]
		if skinType <= odds[4]:
			skinIndex = int(rand_range(0, relicSkins.size()))
			skin.loadSkin(relicSkins[skinIndex])
		elif skinType <= odds[3]:
			skinIndex = int(rand_range(0, exoticSkins.size()))
			skin.loadSkin(exoticSkins[skinIndex])
		elif skinType <= odds[2]:
			skinIndex = int(rand_range(0, rareSkins.size()))
			skin.loadSkin(rareSkins[skinIndex])
		elif skinType <= odds[1]:
			skinIndex = int(rand_range(0, uncommonSkins.size()))
			skin.loadSkin(uncommonSkins[skinIndex])
		print(str(skinType))
	randomize()
	skin.skin.Float = rand_range(0, 1)
	if (skin.skin.Float <= conditions[0]):
		skin.skin.Condition = "Factory New"
		pass
	elif (skin.skin.Float <= conditions[1]):
		skin.skin.Condition = "Tested"
		pass
	elif (skin.skin.Float <= conditions[2]):
		skin.skin.Condition = "Used"
		pass
	elif (skin.skin.Float <= conditions[3]):
		skin.skin.Condition = "Heavily Worn"
		pass
	elif (skin.skin.Float <= conditions[4]):
		skin.skin.Condition = "Battle Scarred"
		pass
	world.add_child(skin)
	skinOpen.show()
	skinOpen.raise()
	skinName.text = skin.skin.Name
	skinStats.text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	skinText.texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.expe += 5
	player.addValue()
	skin.queue_free()
	pass
func _on_Case1_button_up():
	if !isPreorder:
		cSelect.show()
		cMenu.caseskins.clear()
		cMenu.caseName = caseName
		var caseChild = cMenu.SkinsGrid.get_children()
		for i in range(caseChild.size()):
			cMenu.SkinsGrid.get_child(i).queue_free()
		pass
		cMenu.show()
		cMenu.raise()
		cMenu.case = self
		cMenu.caseindex = self.index
		var skinz = []
		skinz.clear()
		for i in range(commonSkins.size()):
			skinz.append(commonSkins[i])
			pass
		for i in range(uncommonSkins.size()):
			skinz.append(uncommonSkins[i])
			pass
		for i in range(rareSkins.size()):
			skinz.append(rareSkins[i])
			pass
		for i in range(exoticSkins.size()):
			skinz.append(exoticSkins[i])
			pass
		for i in range(relicSkins.size()):
			skinz.append(relicSkins[i])
			pass
		if cMenu.caseskins != skinz:
			cMenu.caseskins = skinz
			match (self.type):
				0:
					cMenu.createSkins(skinz)
				1:
					cMenu.createStickers(skinz)
			pass
	pass
