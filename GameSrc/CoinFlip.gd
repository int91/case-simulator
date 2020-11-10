extends Node

onready var player = get_node("/root/World/Player")
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
	$RichTextLabel2.text = "Side: "
	pass

func loseBet(CoinAmount):
	player.gamblingcoins -= CoinAmount
	$RichTextLabel2.text = "Side: "
	pass


func _on_Button_pressed() -> void:
	if float($LineEdit.text) > 0 && BetSide != null && player.gamblingcoins >= float($LineEdit.text):
		flipCoin(GambleAmount)
	else:
		print("No bet")
	pass


func _on_Button2_pressed() -> void:
	BetSide = Side1
	$RichTextLabel2.text = "Side: " + Side1
	pass


func _on_Button3_pressed() -> void:
	BetSide = Side2
	$RichTextLabel2.text = "Side: " + Side2
	pass


func _on_PlusOne_pressed() -> void:
	GambleAmount += 1
	$LineEdit.text = str(GambleAmount)
	pass


func _on_MinusOne_pressed() -> void:
	GambleAmount += 1
	$LineEdit.text = str(GambleAmount)
	pass


func _on_LineEdit_text_changed(new_text: String) -> void:
	GambleAmount = float($LineEdit.text)
	pass
