extends Node

var Guns = ["G18", "Ump", "Bayonet"]
var Rarities = ["Common", "Uncommon", "Rare", "Exotic", "Relic"]
var gun = ""
var rarity = ""
var skinImage = ""
var Values = [0, 0, 0, 0, 0]
var workingDir = null
# Called when the node enters the scene tree for the first time.
func _ready():
	workingDir = ProjectSettings.globalize_path("res://")
	loadSettings()
	$Panel/FileDialog.current_path = workingDir+"/Textures/"
	for i in range(Guns.size()):
		$Panel/Guns.add_item(Guns[i], null, true)
		pass
	for i in range(Rarities.size()):
		$Panel/Rarities.add_item(Rarities[i], null, true)
		pass
	pass # Replace with function body.

func _setvars():
	saveSkin($Panel/ID.text, $Panel/Name.text, gun, rarity, skinImage, Values)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func saveSkin(ID, Name, Gun, Rarity, image, values):
	var saveFile = File.new()
	saveFile.open(workingDir+"/Skins/"+ID+".json", File.WRITE)
	var skinData = {
		"Name":Name,
		"Gun":Gun,
		"Rarity":Rarity,
		"Image":image,
		"Values":values
	}
	saveFile.store_line(to_json(skinData))
	saveFile.close()

func saveSettings():
	var saveFile = File.new()
	saveFile.open(workingDir+"/settings.json", File.WRITE)
	var saveData = {
		"Guns":Guns,
		"Rarities":Rarities
	}
	saveFile.store_line(to_json(saveData))
	saveFile.close()

func loadSettings():
	var saveFile = File.new()
	saveFile.open(workingDir+"/settings.json", File.READ)
	var saveData = parse_json(saveFile.get_line())
	saveFile.close()
	Guns = saveData.Guns
	Rarities = saveData.Rarities

func _on_Guns_item_selected(index):
	gun = $Panel/Guns.get_item_text(index)
	pass


func _on_Rarities_item_selected(index):
	rarity = $Panel/Rarities.get_item_text(index)
	pass


func _on_ImageSelect_pressed():
	$Panel/FileDialog.popup()
	pass


func _on_FileDialog_file_selected(path):
	if ".png" in path:
		skinImage = path
		$Panel/TextureRect.texture = load(skinImage)
	pass


func _on_ImageSelect2_pressed():
	if $Panel/ID.text != null and $Panel/ID.text != "":
		if $Panel/Name.text != null and $Panel/Name.text != "":
			if gun != "":
				if rarity != "":
					if skinImage != null:
						if Values != null and Values != [0 ,0 ,0 ,0, 0] and Values != []:
							_setvars()
						else:
							push_error("Not completed, Missing Values")
							pass
					else:
						push_error("Not completed, Missing skinImage / Texture")
						pass
				else:
					push_error("Not completed, Missing Rarity")
					pass
			else:
				push_error("Not completed, Missing Gun")
				pass
		else:
			push_error("Not completed, Missing Name")
			pass
	else:
		push_error("Not completed, Missing ID")
	pass


func _on_Value0_text_changed(new_text):
	Values[0] = int(new_text)
	pass


func _on_Value1_text_changed(new_text):
	Values[1] = int(new_text)
	pass


func _on_Value2_text_changed(new_text):
	Values[2] = int(new_text)
	pass


func _on_Value3_text_changed(new_text):
	Values[3] = int(new_text)
	pass


func _on_Value4_text_changed(new_text):
	Values[4] = int(new_text)
	pass
