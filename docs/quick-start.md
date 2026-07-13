# Quick Start

## Wallet

```gdscript
@onready var wallet: WalletLite = $WalletLite
# In the Inspector: currency_id = "gold", starting_balance = 100.

wallet.add(50)
wallet.subtract(20)          # returns false if insufficient
wallet.has_amount(100)       # bool
wallet.get_balance()
```

## Vendor

```gdscript
@onready var vendor: VendorLite = $VendorLite

# Stock = Array of Dictionaries.
vendor.stock = [
    {"item": apple,  "price": 5,   "stock": 20, "sell_price": 2},
    {"item": potion, "price": 25,  "stock": 5,  "sell_price": 10},
    {"item": sword,  "price": 150, "stock": 1,  "sell_price": 75},
    {"item": ring,   "price": 300, "stock": -1, "sell_price": 120},  # unlimited
]

vendor.bind_wallet(wallet)
vendor.bind_inventory(bag)

vendor.buy(apple, 3)
vendor.sell(old_sword, 1)
```

## Reject reasons

`transaction_rejected(reason: String)` fires with one of:

- `no_wallet` / `no_inventory` — bindings missing.
- `not_enough_funds` — wallet can't cover the price.
- `out_of_stock` — `stock` array doesn't have enough left.
- `item_not_owned` — player doesn't have the item being sold.
- `item_not_listed` — the vendor doesn't accept this item (and `accept_any_sale` is false).

## Sell-anything mode

Set `vendor.accept_any_sale = true` if the vendor should take any item, even ones not listed in `stock`. Unlisted items sell for 0 unless your code intercepts the `sell()` call first.
