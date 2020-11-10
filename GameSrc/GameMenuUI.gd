extends Control

onready var player = get_node("/root/World/Player")
onready var devCon = $DevConsole
onready var moneyTextStats = $Stats/VBoxContainer/Money
onready var levelTextStats = $Stats/VBoxContainer/Level
onready var expeTextStats = $Stats/VBoxContainer/Expe
onready var SkinsGrid = $CaseSelected/SkinsGrid
onready var CTex = $CaseSelected/CaseTexture
onready var CName = $CaseSelected/CaseTexture/CaseName
onready var Amount = $CaseSelected/Amount
onready var Keys = $CaseSelected/Keys

func _physics_process(delta):
	setGcoins()
	controlDevCon()
	setCornerStats()
	checkCaseSelect()
	pass
func setGcoins():
	$GamesPanel/RichTextLabel.text = "GCoins: " + str(player.gamblingcoins)
	pass
func controlDevCon():
	if Input.is_action_just_pressed("console"):
		if devCon.visible:
			devCon.hide()
			devCon.clear()
		else:
			devCon.show()
			devCon.grab_focus()
	pass
func setCornerStats():
	moneyTextStats.text = "Money: $" + str(player.money)
	levelTextStats.text = "Level: " + str(player.level)
	expeTextStats.text = "Exp: " + str(player.expe) + "/" + str(player.nextLevel)
	pass
#-----------------------------------------------------------
#Responsible For Case Selection Gui
#-----------------------------------------------------------
var caseskins = []
var case = null
var caseindex = null
var caseName = null

func checkCaseSelect():
	if caseindex != null:
		Amount.text = "Amount: " + str(player.cases[caseindex].Amount)
		Keys.text = "Keys: " + str(player.cases[caseindex].Keys)
		CName.text = caseName
		pass
	if Input.is_action_just_pressed("ui_cancel") && self.visible && !$"/root/World/Control/SkinOpened".visible:
		self.hide()
		pass
	pass

func createSkins(caseskins):
	for i in range(caseskins.size()):
		var spawnpath = SkinsGrid
		var instance = load("res://Skins/Skin.tscn")
		var skin = instance.instance()
		skin.loadSkin(caseskins[i])
		skin.InCase = true
		spawnpath.add_child(skin)
	pass

func createStickers(caseskins):
	for i in range(caseskins.size()):
		var spawnpath = SkinsGrid
		var instance = load("res://Skins/Sticker.tscn")
		var skin = instance.instance()
		skin.loadSkin(caseskins[i])
		skin.InCase = true
		spawnpath.add_child(skin)
	pass

func _on_Opencase_pressed():
	if player.cases[caseindex].Amount > 0 && player.cases[caseindex].Keys > 0:
		player.cases[caseindex].Amount -= 1
		player.cases[caseindex].Keys -= 1
		case.openCase()
		pass
	pass

func _on_ClosecaseSelect_pressed():
	$CaseSelected.hide()
	pass

#-----------------------------------------------------------
#Responsible For Handling Games Menu
#-----------------------------------------------------------
onready var Panels = [$GamesPanel/CoinFlip, $GamesPanel/Tower]

func setPanel(index):
	for i in range(Panels.size()):
		if i != index:
			var pa = get_node(Panels[i])
			pa.hide()
			pass
		else:
			var pa = get_node(Panels[index])
			pa.show()
			pass
	pass


func _on_CoinFlipbtn_pressed() -> void:
	setPanel(0)
	pass


func _on_Towerbtn_pressed() -> void:
	setPanel(1)
	pass
	
#-----------------------------------------------------------
#Responsible For GCoins
#-----------------------------------------------------------
func convertCoin(gcoins):
	var money = int(gcoins * 100)
	if player.gamblingcoins >= gcoins && float($Button/LineEdit.text) > 0:
		player.gamblingcoins -= gcoins
		player.money += money
	pass

func _on_ConverGCoin_pressed():
	convertCoin(float($GamesPanel/RichTextLabel.text))
	pass

#-----------------------------------------------------------
#Responsible For DevConsole
#-----------------------------------------------------------
func _on_DevConsole_text_entered(new_text: String) -> void:
	if "give" in self.text.to_lower():
		var p = $"/root/World/Player"
		for i in range(p.cases.size()):
			if p.cases[0] != null:
				p.cases[0].Amount = 1000
				p.cases[0].Keys = 1000
				print("Given!")
		pass
	pass

#-----------------------------------------------------------
#Responsible For TowerGame
#-----------------------------------------------------------
var CurrentRow = 1
var bet = 0
var playing = false

var Row1 = [{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column1/Button",
	"Bomb":false,
	"Reward":1.2},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column2/rButton",
	"Bomb":false,
	"Reward":1.2},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column3/rrButton",
	"Bomb":false,
	"Reward":1.2}]
var Row2 = [{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column1/Button2",
	"Bomb":false,
	"Reward":1.5},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column2/rButton2",
	"Bomb":false,
	"Reward":1.5},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column3/rrButton2",
	"Bomb":false,
	"Reward":1.5}]
var Row3 = [{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column1/Button3",
	"Bomb":false,
	"Reward":2},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column2/rButton3",
	"Bomb":false,
	"Reward":2},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column3/rrButton3",
	"Bomb":false,
	"Reward":2}]
var Row4 = [{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column1/Button4",
	"Bomb":false,
	"Reward":3},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column2/rButton4",
	"Bomb":false,
	"Reward":3},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column3/rrButton4",
	"Bomb":false,
	"Reward":3}]
var Row5 = [{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column1/Button5",
	"Bomb":false,
	"Reward":4.5},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column2/rButton5",
	"Bomb":false,
	"Reward":4.5},{
	"Path":"/root/World/Control/GamesPanel/Tower/BtnGroups/Column3/rrButton5",
	"Bomb":false,
	"Reward":4.5}]

var Selected = []
var Reward = 1.0

func win_tower():
	$Label3.text = "Win"
	var toGive = bet * Reward
	player.gamblingcoins += toGive
	reset_tower()
	pass

func play_tower():
	$Label3.text = ""
	bet = float($LineEdit.text)
	if bet >= 0.01 && !playing:
		$LineEdit.text = ""
		CurrentRow = 1
		reset_tower()
		playing = true
	pass

func lose_tower():
	$Label3.text = "Lose"
	player.gamblingcoins -= bet
	reset_tower()
	pass

func randomise_tower():
	var column = int(rand_range(0,2))
	var maxBombsRow = 1
	for _i in range(maxBombsRow):
		randomize()
		column = int(rand_range(0,3))
		if column == 3:
			column = 2
		Row1[column].Bomb = true
		pass
	for _i in range(maxBombsRow):
		randomize()
		column = int(rand_range(0,3))
		if column == 3:
			column = 2
		Row2[column].Bomb = true
		pass
	for _i in range(maxBombsRow):
		randomize()
		column = int(rand_range(0,3))
		if column == 3:
			column = 2
		Row3[column].Bomb = true
		pass
	for _i in range(maxBombsRow):
		randomize()
		column = int(rand_range(0,3))
		if column == 3:
			column = 2
		Row4[column].Bomb = true
		pass
	for _i in range(maxBombsRow):
		randomize()
		column = int(rand_range(0,3))
		if column == 3:
			column = 2
		Row5[column].Bomb = true
		pass
	pass

func reset_tower():
	Selected = []
	CurrentRow = 1
	for i in range(Row1.size()):
		var node = get_node(Row1[i].Path)
		node.text = "X"
		node = get_node(Row2[i].Path)
		node.text = "X"
		node = get_node(Row3[i].Path)
		node.text = "X"
		node = get_node(Row4[i].Path)
		node.text = "X"
		node = get_node(Row5[i].Path)
		node.text = "X"
	for i in range(Row1.size()):
		Row1[i].Bomb = false
		Row2[i].Bomb = false
		Row3[i].Bomb = false
		Row4[i].Bomb = false
		Row5[i].Bomb = false
		pass
	randomise_tower()
	playing = false
	pass

func select_tower(index, row):
	match row:
		1:
			if Row1[index].Bomb != true:
				for i in range(Row1.size()):
					if i != index:
						pass
					else:
						if Selected.find(Row1[index]) == -1:
							CurrentRow += 1
							var node = get_node(Row1[i].Path)
							Selected.append(Row1[index])
							Reward = Row1[index].Reward
							node.text = "x"+str(Row1[index].Reward)
			else:
				lose_tower()
		2:
			if Row2[index].Bomb != true:
				for i in range(Row2.size()):
					if i != index:
						pass
					else:
						if Selected.find(Row2[index]) == -1:
							CurrentRow += 1
							var node = get_node(Row2[i].Path)
							Selected.append(Row2[index])
							Reward = Row2[index].Reward
							node.text = "x"+str(Row2[index].Reward)
			else:
				lose_tower()
		3:
			if Row3[index].Bomb != true:
				for i in range(Row3.size()):
					if i != index:
						pass
					else:
						if Selected.find(Row3[index]) == -1:
							CurrentRow += 1
							var node = get_node(Row3[i].Path)
							Selected.append(Row3[index])
							Reward = Row3[index].Reward
							node.text = "x"+str(Row3[index].Reward)
			else:
				lose_tower()
		4:
			if Row4[index].Bomb != true:
				for i in range(Row4.size()):
					if i != index:
						pass
					else:
						if Selected.find(Row4[index]) == -1:
							CurrentRow += 1
							var node = get_node(Row4[i].Path)
							Selected.append(Row4[index])
							Reward = Row4[index].Reward
							node.text = "x"+str(Row4[index].Reward)
			else:
				lose_tower()
		5:
			if Row5[index].Bomb != true:
				for i in range(Row5.size()):
					if i != index:
						pass
					else:
						if Selected.find(Row5[index]) == -1:
							CurrentRow += 1
							var node = get_node(Row5[i].Path)
							Selected.append(Row5[index])
							Reward = Row5[index].Reward
							node.text = "x"+str(Row5[index].Reward)
			else:
				lose_tower()
		

func _ready() -> void:
	reset_tower()
	pass


func _on_Button_pressed() -> void:
	if CurrentRow == 1 && playing:
		select_tower(0, 1)
	pass


func _on_rButton_pressed() -> void:
	if CurrentRow == 1 && playing:
		select_tower(1, 1)
	pass


func _on_rrButton_pressed() -> void:
	if CurrentRow == 1 && playing:
		select_tower(2, 1)
	pass


func _on_rrButton2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select_tower(2, 2)
	pass


func _on_rrButton3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select_tower(2, 3)
	pass


func _on_rrButton4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select_tower(2, 4)
	pass


func _on_rrButton5_pressed() -> void:
	if CurrentRow == 5 && playing:
		select_tower(2, 5)
	pass


func _on_CashOut_pressed() -> void:
	if CurrentRow > 1 && playing:
		win_tower()
	pass


func _on_rButton2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select_tower(1, 2)
	pass


func _on_Button2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select_tower(0, 2)
	pass


func _on_Button3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select_tower(0, 3)
	pass


func _on_Button4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select_tower(0, 4)
	pass


func _on_Button5_pressed() -> void:
	if CurrentRow == 5 && playing:
		select_tower(0, 5)
	pass


func _on_rButton5_pressed() -> void:
	if CurrentRow == 5 && playing: 
		select_tower(1, 5)
	pass


func _on_rButton4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select_tower(1, 4)
	pass 


func _on_rButton3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select_tower(1, 3)
	pass


func _on_PLay_pressed() -> void:
	if !playing:
		play_tower()
	pass


#-----------------------------------------------------------
#Responsible For CoinFlips
#-----------------------------------------------------------
var GambleAmount = 0
var Side1 = "Task Force"
var Side2 = "OpFor"
var BetSide = null

func flipCoin(CoinAmount):
	randomize()
	var win = int(rand_range(0,100))
	if win > 50:
		if BetSide == Side1:
			winBet(CoinAmount)
			print("Won")
		else:
			loseBet(CoinAmount)
			print("Lost")
	else:
		if BetSide == Side2:
			winBet(CoinAmount)
			print("Won")
		else:
			loseBet(CoinAmount)
			print("Lost")
	BetSide = null
	pass

func winBet(CoinAmount):
	player.gamblingcoins += CoinAmount
	$GamesPanel/CoinFlip/RichTextLabel2.text = "Side: "
	pass

func loseBet(CoinAmount):
	player.gamblingcoins -= CoinAmount
	$GamesPanel/CoinFlip/RichTextLabel2.text = "Side: "
	pass


func _on_FlipCoin_pressed() -> void:
	if float($GamesPanel/CoinFlip/LineEdit.text) > 0 && BetSide != null && player.gamblingcoins >= float($GamesPanel/CoinFlip/LineEdit.text):
		flipCoin(GambleAmount)
	else:
		print("No bet")
	pass


func _on_BetSide1_pressed() -> void:
	BetSide = Side1
	$GamesPanel/CoinFlip/RichTextLabel2.text = "Side: " + Side1
	pass


func _on_BetSide2_pressed() -> void:
	BetSide = Side2
	$GamesPanel/CoinFlip/RichTextLabel2.text = "Side: " + Side2
	pass


func _on_PlusOne_pressed() -> void:
	GambleAmount += 1
	$GamesPanel/CoinFlip/LineEdit.text = str(GambleAmount)
	pass


func _on_MinusOne_pressed() -> void:
	GambleAmount += 1
	$GamesPanel/CoinFlip/LineEdit.text = str(GambleAmount)
	pass


func _on_LineEdit_text_changed(new_text: String) -> void:
	GambleAmount = float($GamesPanel/CoinFlip/LineEdit.text)
	pass
