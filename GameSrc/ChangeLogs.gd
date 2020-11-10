extends Panel

var Startpos = Vector2(782, 99)
var Endpos = Vector2(782 + 290, 99)
func _ready():
	pass
func _on_CloseButton_pressed():
	$Tween.interpolate_property(self, "rect_position", Startpos, Endpos, 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	pass
	
