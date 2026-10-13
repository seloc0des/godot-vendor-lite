# Quick Start

## With the Setup tab (no code)

1. Enable **Vendor (Lite)** in Project → Project Settings → Plugins. The **Vendor · Setup** tab appears.
2. Select your player node. Pick **Give the player a wallet**, set **Starting balance** and press **Apply**. The player gets a `WalletLite` and is marked as the player.
3. If your player has no bag yet, give it one. The **Inventory · Setup** tab of Inventory (Lite) does it: select the player, pick **Player inventory**, press **Apply**.
4. Select your shopkeeper. Pick **A shop / vendor** and press **Apply**. The shopkeeper gets a `VendorLite` and a `ShopArea`, and a hidden `ShopPanel` goes on a UI layer.
5. Fill in what it sells under **3. What does the shop sell?** in the same tab. With the shopkeeper (or its `VendorLite`) selected, press **Add row** for each item: pick the item, then set **Price**, **Buys back** (what the shop pays when the player sells it back) and **Stock**, or tick **No limit**. The item list shows your own items from `res://items` first, then the demo's as examples. **New item** makes `res://items/new_item.tres`, puts it on a new row and opens it in the Inspector to name it and pick an icon. **Remove** takes a row out.
6. Save and press Play. Walk into the shopkeeper's area and the panel opens in the lower middle of the screen. Walk away or press **Close** to shut it.

The status line under **Apply** says what's still missing: nothing marked as the player yet (select your player and press **Make the selected node the player**), or no wallet or bag on the player.

In the panel, **Buy** greys out when the player can't afford an item or it's sold out. The **Sell** list shows the items in the player's bag that the shop buys. When a purchase is turned down, the panel says why.

The rows are the shop's own Stock, saved with the scene. Select another shop and the rows switch to it.

To move the panel, select `UILayer/ShopPanel` and drag it or change its anchors. Apply again won't move it back. To make the walk-up area bigger, select `ShopArea/CollisionShape` and change its radius.

## Reject reasons

The panel shows these as plain sentences. From code, `transaction_rejected(reason: String)` fires with one of:

- `no_wallet` / `no_inventory`: nothing bound, and nothing found on the player.
- `not_enough_funds`: the wallet can't cover the price.
- `out_of_stock`: the stock entry doesn't have enough left.
- `item_not_owned`: the player doesn't have the item being sold.
- `item_not_in_stock`: the vendor doesn't take this item (and `accept_any_sale` is off).
- `bag_full`: the bag had no room for it. The gold goes back to the wallet.

## Sell-anything mode

Tick **Accept Any Sale** on the `VendorLite` if the vendor should take any item, even ones not in its Stock. Unlisted items sell for 0.

## From code (optional)

### Wallet

```gdscript
@onready var wallet: WalletLite = $WalletLite
# In the Inspector: currency_id = "gold", starting_balance = 100.

wallet.add(50)
wallet.subtract(20)          # returns false if insufficient
wallet.has_amount(100)       # bool
wallet.get_balance()
```

### Vendor

```gdscript
@onready var vendor: VendorLite = $VendorLite

# Stock = Array of Dictionaries.
vendor.stock = [
    {"item": apple,  "price": 5,   "stock": 20, "sell_price": 2},
    {"item": potion, "price": 25,  "stock": 5,  "sell_price": 10},
    {"item": sword,  "price": 150, "stock": 1,  "sell_price": 75},
    {"item": ring,   "price": 300, "stock": -1, "sell_price": 120},  # unlimited
]

# Bind them yourself, or call vendor.link_player() to use the wallet and bag
# on the "player" group's node. The ShopPanel calls it when it opens.
vendor.bind_wallet(wallet)
vendor.bind_inventory(bag)

vendor.buy(apple, 3)
vendor.sell(old_sword, 1)
```
