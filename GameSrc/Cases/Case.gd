extends TextureButton

onready var player = $"../../../Player"
onready var world = get_node("/root") 
onready var nameNode = $CaseName
onready var caseAmount = $CaseAmount
var ID = "OACase"
var index = 0
var unlockLevel = 0
var caseName = "Operation Alpha"
var odds = [100, 20, 10, 5, 2]
var commonSkins = ["SkinDef"]
var uncommonSkins = ["UmpPHaze"]
var rareSkins = ["UmpBHaze"]
var exoticSkins = ["G18DeadWeight"]
var relicSkins = ["BayonetPHaze"]
var totalSkins = 0
var conditions = [0.23, 0.54, 0.73, 0.89, 1]
func _ready():
	totalSkins = commonSkins.size() + uncommonSkins.size() + rareSkins.size() + exoticSkins.size()
	if totalSkins > 25:
		push_error(caseName + " Case has too many non-relic skins, please change the amount of skins in the case.")
		pass
	nameNode.text = caseName
	pass
func _physics_process(delta):
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
	pass
func openCase():
	var skinType = int(rand_range(1, 100))
	print(skinType)
	if (skinType <= odds[0] && skinType > odds[1]):
		commonCase()
		pass
	if (skinType <= odds[1] && skinType > odds[2]):
		uncommonCase()
		pass
	if (skinType <= odds[2] && skinType > odds[3]):
		rareCase()
		pass
	if (skinType <= odds[3] && skinType > odds[4]):
		exoticCase()
		pass
	if (skinType <= odds[4]):
		relicCase()
		pass
	pass
func commonCase():
	randomize()
	var skinIndex = int(rand_range(0, commonSkins.size()))
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.loadSkin(commonSkins[skinIndex])
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
	$"../../SkinOpened".show()
	$"../../SkinOpened/SkinName".text = skin.skin.Name
	$"../../SkinOpened/SkinStats".text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	$"../../SkinOpened/SkinTexture".texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.inventory.append(skin.skin)
	player.expe += 5
	skin.queue_free()
	pass
func uncommonCase():
	randomize()
	var skinIndex = int(rand_range(0, uncommonSkins.size()))
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.loadSkin(uncommonSkins[skinIndex])
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
	$"../../SkinOpened".show()
	$"../../SkinOpened/SkinName".text = skin.skin.Name
	$"../../SkinOpened/SkinStats".text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	$"../../SkinOpened/SkinTexture".texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.inventory.append(skin.skin)
	player.expe += 10
	skin.queue_free()
	pass
func rareCase():
	randomize()
	var skinIndex = int(rand_range(0, rareSkins.size()))
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.loadSkin(rareSkins[skinIndex])
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
	$"../../SkinOpened".show()
	$"../../SkinOpened/SkinName".text = skin.skin.Name
	$"../../SkinOpened/SkinStats".text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	$"../../SkinOpened/SkinTexture".texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.inventory.append(skin.skin)
	player.expe += 15
	skin.queue_free()
	pass
func exoticCase():
	randomize()
	var skinIndex = int(rand_range(0, exoticSkins.size()))
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.loadSkin(exoticSkins[skinIndex])
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
	$"../../SkinOpened".show()
	$"../../SkinOpened/SkinName".text = skin.skin.Name
	$"../../SkinOpened/SkinStats".text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	$"../../SkinOpened/SkinTexture".texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.inventory.append(skin.skin)
	skin.queue_free()
	player.expe += 20
	pass
func relicCase():
	randomize()
	var skinIndex = int(rand_range(0, relicSkins.size()))
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.loadSkin(relicSkins[skinIndex])
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
	$"../../SkinOpened".show()
	$"../../SkinOpened/SkinName".text = skin.skin.Name
	$"../../SkinOpened/SkinStats".text = str("Rarity: " + str(skin.skin.Rarity) + "\n" + "Float: " 
	+ str(skin.skin.Float) + "\n" + "Condition: " + str(skin.skin.Condition) + "\n" + 
	"Value: $" + str(skin.skin.Value))
	$"../../SkinOpened/SkinTexture".texture = load(skin.skin.Image)
	player.createItem("Skins/Skin.tscn", skin.skin)
	player.inventory.append(skin.skin)
	player.expe += 25
	skin.queue_free()
	pass
func _on_Case1_button_up():
	#if !$"../../SkinOpened".visible:
	if player.cases[index].Amount > 0 && player.cases[index].Keys > 0:
		openCase()
		player.cases[index].Amount -= 1
		player.cases[index].Keys -= 1
		pass
		#pass
	pass
