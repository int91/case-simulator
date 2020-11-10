extends VBoxContainer

onready var openBtnTween = $"../OpenMenu/Tween"
onready var openBtn = $"../OpenMenu"
var Panels = ["../CasesPanel", "../InvPanel", "../ShopPanel", "../GamesPanel", "../HomePanel"]
var menuOpen = true
var buttonOpen = Vector2(0, 172)
var buttonClose = Vector2(-24, 172)
var openedMenu = Vector2(3, 17)
var closedMenu = Vector2(-140, 17)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func setPanel(index):
	var HomeIndex = Panels.find("../HomePanel")
	for i in range(Panels.size()):
		if i != index && i != HomeIndex:
			var pa = get_node(Panels[i])
			pa.hide()
			pass
		else:
			var pa = get_node(Panels[index])
			pa.show()
			pass
	pass

func closeAllPanels():
	var HomeIndex = Panels.find("../HomePanel")
	for i in Panels.size():
		if i != HomeIndex:
			get_node(Panels[i]).hide()
			pass
		pass
	pass
	 
func closeMenu():
	$Tween.interpolate_property(self, "rect_position", openedMenu, closedMenu, 0.8, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	openBtnTween.interpolate_property(openBtn, "rect_position", buttonClose, buttonOpen, 0.8, Tween.TRANS_CUBIC, Tween.EASE_IN)
	openBtnTween.start()
	pass

func openMenu():
	$Tween.interpolate_property(self, "rect_position", closedMenu, openedMenu, 0.8, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	openBtnTween.interpolate_property(openBtn, "rect_position", buttonOpen, buttonClose, 0.8, Tween.TRANS_CUBIC, Tween.EASE_IN)
	openBtnTween.start()
	pass

func _on_CasesBtn_pressed() -> void:
	setPanel(0)
	pass


func _on_InvBtn_pressed() -> void:
	setPanel(1)
	pass


func _on_ShopBtn_pressed() -> void:
	setPanel(2)
	pass


func _on_GamesBtn_pressed() -> void:
	setPanel(3)
	pass


func _on_HomeBtn_pressed() -> void:
	if menuOpen:
		closeMenu()
		closeAllPanels()
		menuOpen = false
	pass


func _on_OpenMenu_pressed() -> void:
	openMenu()
	menuOpen = true
	pass
