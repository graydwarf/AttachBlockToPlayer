extends Node2D

func RemoveItemFromWorld(item):
	remove_child(item)
	
func AddItemToWorld(item, globalPosition):
	add_child(item)
	item.global_position = globalPosition

func _input(inputEvent):
	if inputEvent is InputEventKey and not inputEvent.echo:
		if Input.is_key_pressed(KEY_ENTER):
			Signals.emit_signal("EnterKeyPressed")
