extends Node

onready var inventoryGrid = $"../Control/InvPanel/InvContainer/InvGrid"
onready var skinSelected = $"../Control/SkinSelected"
onready var openCases = $"../Control/CasesPanel/OpenCases"
onready var invWorth = $"../Control/InvPanel/Label2"
onready var totalSkins = $"../Control/InvPanel/Label"
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
			initInv(inventory[i])
			addValue()
		pass
	openCases.addCases()
	pass
func addValue():
	var invValue = 0
	if inventory.size() != 0:
		for i in range(inventory.size()):
			invValue += inventory[i].Value
		pass
	invWorth.text = "Inventory Value: $" + str(invValue)
	pass
func initInv(stats):
	var spawnpath = inventoryGrid
	var instance = load("Skins/Skin.tscn")
	var skin = instance.instance()
	skin.skin = stats
	skin.inInv = true
	spawnpath.add_child(skin)
	pass
func createItem(Itempath, stats):
	inventory.append(stats)
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
	totalSkins.text = "Total Items: " + str(inventory.size())
	if expe >= nextLevel:
		expe -= nextLevel
		level += 1
		nextLevel = 100 * level
		pass
	if Input.is_action_just_pressed("gamble"):
		Settings.GamblingSell = !Settings.GamblingSell
	pass
