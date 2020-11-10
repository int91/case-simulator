extends TextureButton

onready var player = get_node("/root/World/Player")
var price = 5
var index = 0
var hovered = false

func _ready():
	pass
	
func loadCase(caseID):
	var saveFile = File.new()
	saveFile.open("res://Cases/"+caseID, File.READ)
	var caseData = parse_json(saveFile.get_line())
	saveFile.close()
	self.price = caseData.Price
	$CaseName.text = caseData.CaseName + "\nCase Key\n$" + str(price)
	pass

func _on_CaseStore_pressed() -> void:
	if player.money >= price:
			player.cases[index].Keys += 1
			player.money -= price
			pass
	pass
