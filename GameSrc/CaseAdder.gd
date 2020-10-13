extends HBoxContainer

onready var player = get_node("/root/World/Player")
onready var Store = get_node("/root/World/Control/Shop/Cases/GridContainer")
var Cases = []
func _ready():
	pass
func addCases():
	player = get_node("/root/World/Player")
	Store = get_node("/root/World/Control/Shop/Cases/GridContainer")
	Cases = getCases()
	for i in range(Cases.size()):
		if player.cases != []:
			if player.cases.size() < Cases.size():
				player.cases.append({"Amount": 0, "Keys": 0})
		elif player.cases == []:
			player.cases.append({"Amount": 0, "Keys": 0})
		var caseInst = load("res://Cases/Case.tscn")
		var case = caseInst.instance()
		case.loadCase(Cases[i])
		case.index = i
		self.add_child(case)
		var caseShopInst = load("res://Cases/CaseStore.tscn")
		var csI = caseShopInst.instance()
		csI.loadCase(Cases[i])
		csI.index = i
		Store.add_child(csI)
		pass
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
