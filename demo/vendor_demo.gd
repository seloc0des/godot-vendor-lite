extends Node

const DemoBag := preload("res://addons/vendor_lite/_demo_bag.gd")
const WalletLiteScript := preload("res://addons/vendor_lite/wallet_lite.gd")
const VendorLiteScript := preload("res://addons/vendor_lite/vendor_lite.gd")

class _Item extends Resource:
	var id: String = ""
	var name: String = ""

var _bag: Node
var _wallet: WalletLite
var _vendor: VendorLite
var _items: Dictionary = {}
var _status: Label
var _shop_panel: VBoxContainer
var _bag_panel: VBoxContainer
var _wallet_label: Label


func _ready() -> void:
	var bg := ColorRect.new()
	bg.color = Color(0.10, 0.12, 0.16)
	bg.anchor_right = 1; bg.anchor_bottom = 1
	add_child(bg)

	_items["apple"] = _make("apple", "Apple")
	_items["potion"] = _make("potion", "Health Potion")
	_items["sword"] = _make("sword", "Iron Sword")
	_items["ring"] = _make("ring", "Magic Ring")

	_bag = DemoBag.new()
	add_child(_bag)
	_wallet = WalletLiteScript.new()
	_wallet.currency_id = "gold"
	_wallet.starting_balance = 100
	add_child(_wallet)
	_wallet.balance_changed.connect(func(_v): _refresh())

	_vendor = VendorLiteScript.new()
	_vendor.stock = [
		{"item": _items["apple"],  "price": 5,   "stock": 20, "sell_price": 2},
		{"item": _items["potion"], "price": 25,  "stock": 5,  "sell_price": 10},
		{"item": _items["sword"],  "price": 150, "stock": 1,  "sell_price": 75},
		{"item": _items["ring"],   "price": 300, "stock": -1, "sell_price": 120},  # unlimited
	]
	_vendor.bind_wallet(_wallet)
	_vendor.bind_inventory(_bag)
	add_child(_vendor)
	_vendor.stock_changed.connect(_refresh)
	_vendor.transaction_rejected.connect(func(reason): _flash("Rejected: %s" % reason))
	_bag.contents_changed.connect(_refresh)

	_build_ui()
	_refresh()


func _make(id_: String, name_: String) -> Resource:
	var it := _Item.new()
	it.id = id_; it.name = name_
	return it


func _build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var title := Label.new()
	title.text = "Vendor (Lite) · Demo"
	title.position = Vector2(16, 12)
	title.add_theme_font_size_override("font_size", 16)
	layer.add_child(title)

	_wallet_label = Label.new()
	_wallet_label.position = Vector2(740, 12)
	_wallet_label.add_theme_font_size_override("font_size", 14)
	layer.add_child(_wallet_label)

	var topup := Button.new()
	topup.text = "+50 gold"
	topup.position = Vector2(740, 36)
	topup.pressed.connect(_wallet.add.bind(50))
	layer.add_child(topup)

	# Shop (left).
	var shop_box := PanelContainer.new()
	shop_box.position = Vector2(16, 64)
	shop_box.custom_minimum_size = Vector2(440, 440)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.04, 0.05, 0.07)
	sb.border_color = Color(0.20, 0.22, 0.28)
	sb.set_border_width_all(1); sb.set_corner_radius_all(4)
	sb.content_margin_left = 12; sb.content_margin_right = 12
	sb.content_margin_top = 12; sb.content_margin_bottom = 12
	shop_box.add_theme_stylebox_override("panel", sb)
	layer.add_child(shop_box)
	_shop_panel = VBoxContainer.new()
	_shop_panel.add_theme_constant_override("separation", 4)
	shop_box.add_child(_shop_panel)

	# Bag (right).
	var bag_box := PanelContainer.new()
	bag_box.position = Vector2(476, 64)
	bag_box.custom_minimum_size = Vector2(408, 440)
	bag_box.add_theme_stylebox_override("panel", sb.duplicate())
	layer.add_child(bag_box)
	_bag_panel = VBoxContainer.new()
	_bag_panel.add_theme_constant_override("separation", 4)
	bag_box.add_child(_bag_panel)

	_status = Label.new()
	_status.position = Vector2(16, 510)
	_status.add_theme_font_size_override("font_size", 12)
	_status.modulate = Color(1, 1, 1, 0.75)
	layer.add_child(_status)


func _refresh() -> void:
	_wallet_label.text = "Gold: %d" % _wallet.get_balance()

	# Shop side.
	for c in _shop_panel.get_children():
		c.queue_free()
	var hdr := Label.new()
	hdr.text = "Shop (Buy)"
	hdr.add_theme_font_size_override("font_size", 14)
	_shop_panel.add_child(hdr)
	for e in _vendor.stock:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 8)
		_shop_panel.add_child(row)
		var stock_text := "∞" if int(e.get("stock", -1)) < 0 else str(int(e.stock))
		var label := Label.new()
		label.text = "%s: %dg (stock %s)" % [String(e.item.name), int(e.price), stock_text]
		label.add_theme_font_size_override("font_size", 12)
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(label)
		var btn := Button.new()
		btn.text = "Buy"
		btn.pressed.connect(_vendor.buy.bind(e.item, 1))
		row.add_child(btn)

	# Bag side.
	for c in _bag_panel.get_children():
		c.queue_free()
	var bhdr := Label.new()
	bhdr.text = "Bag (Sell)"
	bhdr.add_theme_font_size_override("font_size", 14)
	_bag_panel.add_child(bhdr)
	for s in _bag.snapshot():
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 8)
		_bag_panel.add_child(row)
		var sp := _vendor.get_sell_price(s.item)
		var label := Label.new()
		label.text = "%s ×%d: sell %dg" % [String(s.item.name), int(s.count), sp]
		label.add_theme_font_size_override("font_size", 12)
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(label)
		var btn := Button.new()
		btn.text = "Sell 1"
		btn.pressed.connect(_vendor.sell.bind(s.item, 1))
		row.add_child(btn)
	if _bag.snapshot().is_empty():
		var empty := Label.new()
		empty.text = "  (empty)"
		empty.modulate = Color(1, 1, 1, 0.5)
		_bag_panel.add_child(empty)


var _flash_until: float = 0.0


func _flash(msg: String) -> void:
	_status.text = msg
	_flash_until = Time.get_ticks_msec() / 1000.0 + 2.0


func _process(_dt: float) -> void:
	if Time.get_ticks_msec() / 1000.0 >= _flash_until and _status != null:
		_status.text = ""
