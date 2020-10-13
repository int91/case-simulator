extends TextureButton

onready var player = get_node("/root/World/Player")
var price = 5

func _ready():
	pass
	
func loadCase(caseID):
	var saveFile = File.new()
	saveFile.open("res://Cases/"+caseID, File.READ)
	var caseData = parse_json(saveFile.get_line())
	saveFile.close()
	self.price = caseData.Price
	$CaseName.text = caseData.CaseName
	pass

func _on_OperationAlphaCase_pressed():
	
	pass
