extends Resource
class_name Item_Resource

#public
@export var item_name : String = "item name"
@export var unique : bool = false

#private
var count : int = 1 #Used in Inventory
var in_inventory : bool = false #Used in Item List to keep track
