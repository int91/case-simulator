extends Panel

onready var player = get_node("/root/World/Player")

func _ready():
	pass
func _process(delta):
	$VBoxContainer/Money.text = "Money: $" + str(player.money)
	$VBoxContainer/Level.text = "Level: " + str(player.level)
	$VBoxContainer/Expe.text = "Exp: " + str(player.expe) + "/" + str(player.nextLevel)
	pass
