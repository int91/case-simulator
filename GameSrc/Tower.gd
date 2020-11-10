extends Panel

var CurrentRow = 1
var bet = 0
var playing = false

onready var player = get_node("/root/World/Player")
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

func win():
	$Label3.text = "Win"
	var toGive = bet * Reward
	player.gamblingcoins += toGive
	reset()
	pass

func play():
	$Label3.text = ""
	bet = float($LineEdit.text)
	if bet >= 0.01 && !playing:
		$LineEdit.text = ""
		CurrentRow = 1
		reset()
		playing = true
	pass

func lose():
	$Label3.text = "Lose"
	player.gamblingcoins -= bet
	reset()
	pass

func randomise():
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

func reset():
	Selected = []
	CurrentRow = 1
	for i in range(Row1.size()):
		var node = get_node(Row1[i].Path)
		node.text = "X"
	for i in range(Row2.size()):
		var node = get_node(Row2[i].Path)
		node.text = "X"
	for i in range(Row3.size()):
		var node = get_node(Row3[i].Path)
		node.text = "X"
	for i in range(Row4.size()):
		var node = get_node(Row4[i].Path)
		node.text = "X"
	for i in range(Row5.size()):
		var node = get_node(Row5[i].Path)
		node.text = "X"
	for i in range(Row1.size()):
		Row1[i].Bomb = false
		pass
	for i in range(Row2.size()):
		Row2[i].Bomb = false
		pass
	for i in range(Row3.size()):
		Row3[i].Bomb = false
		pass
	for i in range(Row4.size()):
		Row4[i].Bomb = false
		pass
	for i in range(Row5.size()):
		Row5[i].Bomb = false
		pass
	randomise()
	playing = false
	pass

func select(index, row):
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
				lose()
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
				lose()
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
				lose()
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
				lose()
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
				lose()
		

func _ready() -> void:
	reset()
	pass


func _on_Button_pressed() -> void:
	if CurrentRow == 1 && playing:
		select(0, 1)
	pass


func _on_rButton_pressed() -> void:
	if CurrentRow == 1 && playing:
		select(1, 1)
	pass


func _on_rrButton_pressed() -> void:
	if CurrentRow == 1 && playing:
		select(2, 1)
	pass


func _on_rrButton2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select(2, 2)
	pass


func _on_rrButton3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select(2, 3)
	pass


func _on_rrButton4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select(2, 4)
	pass


func _on_rrButton5_pressed() -> void:
	if CurrentRow == 5 && playing:
		select(2, 5)
	pass


func _on_CashOut_pressed() -> void:
	if CurrentRow > 1 && playing:
		win()
	pass


func _on_rButton2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select(1, 2)
	pass


func _on_Button2_pressed() -> void:
	if CurrentRow == 2 && playing:
		select(0, 2)
	pass


func _on_Button3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select(0, 3)
	pass


func _on_Button4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select(0, 4)
	pass


func _on_Button5_pressed() -> void:
	if CurrentRow == 5 && playing:
		select(0, 5)
	pass


func _on_rButton5_pressed() -> void:
	if CurrentRow == 5 && playing: 
		select(1, 5)
	pass


func _on_rButton4_pressed() -> void:
	if CurrentRow == 4 && playing:
		select(1, 4)
	pass 


func _on_rButton3_pressed() -> void:
	if CurrentRow == 3 && playing:
		select(1, 3)
	pass


func _on_PLay_pressed() -> void:
	if !playing:
		play()
	pass
