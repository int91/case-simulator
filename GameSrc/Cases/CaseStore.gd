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
	$CaseName.text = caseData.CaseName + "\n$" + str(price)
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_rightclick") && hovered:
		if player.money >= price:
			player.cases[index].Keys += 1
			player.money -= price
			pass
		pass
	pass

func _on_OperationAlphaCase_pressed():
	if player.money >= price:
		player.cases[index].Amount += 1
		player.money -= price
		pass
	pass


func _on_CaseStore_mouse_entered():
	self.hovered = true
	pass


func _on_CaseStore_mouse_exited():
	self.hovered = false
	pass
