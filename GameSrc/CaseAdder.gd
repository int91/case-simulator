extends HBoxContainer

onready var player = get_node("/root/World/Player")
onready var cStore = get_node("/root/World/Control/ShopPanel/Shop/Cases/GridContainer")
onready var cKeyStore = get_node("/root/World/Control/ShopPanel/Shop/Keys/GridContainer")
var Cases = []
var cachedCases = []
func _ready():
	pass
func addCases():
	loadCache()
	player = get_node("/root/World/Player")
	cStore = get_node("/root/World/Control/ShopPanel/Shop/Cases/GridContainer")
	var sStore = get_node("/root/World/Control/ShopPanel/Shop/Stickers/GridContainer")
	var chStore = get_node("/root/World/Control/ShopPanel/Shop/Charms/GridContainer")
	cKeyStore = get_node("/root/World/Control/ShopPanel/Shop/Keys/GridContainer")
	Cases = getCases()
	for i in range(Cases.size()):
		if player.cases != []:
			if player.cases.size() < Cases.size():
				player.cases.append({"Amount": 0, "Keys": 0})
		elif player.cases == []:
			player.cases.append({"Amount": 0, "Keys": 0})
		elif player.cases.size() < Cases.size() && Cases < cachedCases:
			player.cases[i+1] = player.cases[i]
		elif player.cases.size() > Cases.size() && Cases > cachedCases:
			player.cases[i-1] = player.cases[i]
			player.cases.remove(player.cases.size())
			pass
		var caseInst = load("res://Cases/Case.tscn")
		var case = caseInst.instance()
		case.loadCase(Cases[i])
		case.index = i
		self.add_child(case)
		if case.type == 0:
			var caseShopInst = load("res://Cases/CaseStore.tscn")
			var csI = caseShopInst.instance()
			csI.loadCase(Cases[i])
			csI.index = i
			cStore.add_child(csI)
		elif case.type == 1:
			var caseShopInst = load("res://Cases/CaseStore.tscn")
			var csI = caseShopInst.instance()
			csI.loadCase(Cases[i])
			csI.index = i
			sStore.add_child(csI)
		elif case.type == 2:
			var caseShopInst = load("res://Cases/CaseStore.tscn")
			var csI = caseShopInst.instance()
			csI.loadCase(Cases[i])
			csI.index = i
			chStore.add_child(csI)
		else:
			print("No type found")
		var caseKeyShopInst = load("res://Cases/CaseKeyStore.tscn")
		var ckey = caseKeyShopInst.instance()
		ckey.loadCase(Cases[i])
		ckey.index = i
		cKeyStore.add_child(ckey)
		pass
		cacheCases()
	pass
func loadCache():
	var saveFile = File.new()
	saveFile.open("res://cache/cases.json", saveFile.READ)
	var data = parse_json(saveFile.get_line())
	self.cachedCases = data.Cases
	pass
func cacheCases():
	var saveFile = File.new()
	var data = {"Cases": Cases}
	saveFile.open("res://cache/cases.json", saveFile.WRITE)
	saveFile.store_line(to_json(data))
	pass
func getCases():
	var files = []
	var dir = Directory.new()
	dir.open("res://Cases/")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if ".json" in file:
				files.append(file)
	dir.list_dir_end()
	return files
	pass
