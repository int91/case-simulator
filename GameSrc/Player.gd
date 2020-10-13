extends Node

onready var inventoryPanel = $"../Control/Inventory"
onready var inventoryGrid = $"../Control/Inventory/ScrollContainer/InvGrid"
onready var shopPanel = $"../Control/Shop"
onready var casePanel = $"../Control/OpenCases"
onready var skinSelected = $"../Control/SkinSelected"
onready var openCases = $"../Control/OpenCases"
var inventory = []
var cases = []
var stickers = []
var charms = []
var hats = []
var masks = []
var shirts = []
var pants = []
var gloves = []
var gamblingcoins = 0
var money = 50
var level = 1
var expe = 0
var nextLevel = 100 * level
func _ready():
	get_tree().set_auto_accept_quit(false)
	var f = File.new()
	if f.file_exists("res://save.json"):
		loadPlayerData()
	else:
		savePlayerData()
	if inventory != []:
		for i in range(inventory.size()):
			createItem("Skins/Skin.tscn", inventory[i])
			pass
		pass
	openCases.addCases()
	pass
func createItem(Itempath, stats):
	var spawnpath = inventoryGrid
	var instance = load(Itempath)
	var skin = instance.instance()
	skin.skin = stats
	spawnpath.add_child(skin)
	pass
func loadPlayerData():
	var saveFile = File.new()
	saveFile.open("res://save.json", File.READ)
	var data = parse_json(saveFile.get_line())
	saveFile.close()
	self.inventory = data.Inventory
	self.cases = data.Cases
	self.level = data.Level
	self.expe = data.Expe
	self.gamblingcoins = data.GamblingCoins
	self.nextLevel = data.NextLevel
	self.money = data.Money
	self.stickers = data.Stickers
	self.charms = data.Charms
	self.hats = data.Hats
	self.masks = data.Masks
	self.shirts = data.Shirts
	self.pants = data.Pants
	self.gloves = data.Gloves
	pass
func savePlayerData():
	var saveFile = File.new()
	saveFile.open("res://save.json", File.WRITE)
	var saveData = {
		"Inventory":self.inventory,
		"Cases":self.cases,
		"Stickers":self.stickers,
		"Charms":self.charms,
		"Hats":self.hats,
		"Masks":self.masks,
		"Shirts":self.shirts,
		"Pants":self.pants,
		"Gloves":self.gloves,
		"Money":self.money,
		"GamblingCoins":self.gamblingcoins,
		"Level":self.level,
		"Expe":self.expe,
		"NextLevel":self.nextLevel
	}
	saveFile.store_line(to_json(saveData))
	saveFile.close()
	pass
func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		savePlayerData()
		get_tree().quit()
	pass
func _process(delta):
	if expe >= nextLevel:
		expe -= nextLevel
		level += 1
		nextLevel = 100 * level
		pass
	if Input.is_action_just_pressed("tab"):
		if inventoryPanel.visible:
			skinSelected.hide()
			inventoryPanel.hide()
		else:
			inventoryPanel.show()
	if Input.is_action_just_pressed("shop"):
		if shopPanel.visible:
			skinSelected.hide()
			shopPanel.hide()
		else:
			shopPanel.show()
	if Input.is_action_just_pressed("cases"):
		if casePanel.visible:
			skinSelected.hide()
			casePanel.hide()
		else:
			casePanel.show()
	if Input.is_action_just_pressed("controls"):
		if $"../Control/Controls".visible:
			skinSelected.hide()
			$"../Control/Controls".hide()
		else:
			$"../Control/Controls".show()
	pass
