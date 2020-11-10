extends Panel

onready var player = get_node("/root/World/Player")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$RichTextLabel.text = "GCoins: " + str(player.gamblingcoins)
	pass

func convertCoin(gcoins):
	var money = int(gcoins * 100)
	if player.gamblingcoins >= gcoins && float($Button/LineEdit.text) > 0:
		player.gamblingcoins -= gcoins
		player.money += money
	pass

func _on_Button_pressed() -> void:
	convertCoin(float($Button/LineEdit.text))
	pass
