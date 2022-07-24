extends KinematicBody2D

const ACCELERATION = 960
const MAX_SPEED = 155
const FRICTION = 900
var velocity : Vector2
var _actionableItem

func _ready():
	InitSignals()

func InitSignals():
	Signals.connect("EnterKeyPressed", self, "EnterKeyPressed")
	Signals.connect("PlayerEnteredPickupArea", self, "PlayerEnteredPickupArea")

func EnterKeyPressed():
	if GetHeldItem() != null:
		DropHeldItem()
	elif _actionableItem:
		var globalPosition = _actionableItem.global_position
		get_parent().RemoveItemFromWorld(_actionableItem)
		PickupActionableItem()
		_actionableItem.global_position = globalPosition
		
func PlayerEnteredPickupArea(item):
	if GetHeldItem() != null:
		# can't pickup two items
		return
	
	_actionableItem = item

func _physics_process(delta):
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	velocity = velocity.move_toward(Vector2(input_x, -input_y) * MAX_SPEED, ACCELERATION * delta)

	velocity = move_and_slide(velocity, Vector2.UP)

func GetHeldItem():
	if $ItemContainer.get_child_count() > 0:
		return $ItemContainer.get_child(0)
	else:
		return null
	
func DropHeldItem():
	if GetHeldItem() != null:
		var globalPosition = GetHeldItem().global_position
		var heldItem = GetHeldItem()
		$ItemContainer.remove_child(heldItem)
		get_parent().AddItemToWorld(heldItem, globalPosition)
		
func PickupActionableItem():
	if _actionableItem != null:
		$ItemContainer.add_child(_actionableItem)
		
	
