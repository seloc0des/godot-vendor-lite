# Vendor — Lite

**FREE.** Single-currency vendor/shop for Godot 4.3+. Pure GDScript. MIT.

The working core of the [CindieForge Vendor addon](docs/upgrade.md). One `WalletLite` for currency, one `VendorLite` for the shop. Buy and sell with two methods.

## 5-minute install

1. Copy `addons/vendor_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Vendor — Lite**.
3. Add a `WalletLite` Node to your player. Set `currency_id` and `starting_balance`.
4. Add a `VendorLite` Node to your shopkeeper. Set `stock` (Array of `{item, price, stock, sell_price?}`).
5. Bind wallet + inventory: `vendor.bind_wallet(wallet); vendor.bind_inventory(bag)`.
6. `vendor.buy(item, n)`, `vendor.sell(item, n)`.

```gdscript
vendor.stock = [
    {"item": apple, "price": 5, "stock": 20, "sell_price": 2},
    {"item": ring,  "price": 300, "stock": -1, "sell_price": 120},  # -1 stock = unlimited
]
vendor.buy(apple, 3)       # subtracts 15g, adds 3 apples to bag, decrements stock
vendor.sell(old_sword, 1)  # adds sword's sell_price to wallet, removes from bag
```

## What's missing (and why)

| Feature | Tier |
|---|---|
| Multi-currency wallets (gold + gems + …) | Pro |
| Buyback ratio (auto-derive sell from buy price) | Pro |
| Restock timers (`restock_seconds`) | Pro |
| Conditional offers (flag / level / quest gating) | Pro |
| Timed offers (`available_until` deadlines) | Pro |
| Category-only sell-back filtering | Pro |
| Drop-in `ShopUI` Control | Pro |
| Save-contract auto-join + shared `Events` bus | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


---

## Part of a family

The free Lite tier of one system in a set of Godot 4 RPG systems built to
interoperate (shared item + save contracts) — each also works fully standalone.

**Free tiers — try before you buy:**

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite) — item slots, stack merging, capacity
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite) — 4-slot gear manager
- [Save/Load Lite](https://github.com/seloc0des/godot-save-load-lite) — single-slot JSON persistence
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite) — shapeless instant recipes
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite) — COLLECT + KILL quests
- [Stats/Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite) — stat aggregator
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite) — single fixed-currency shop
- [Settings + Menu System](https://github.com/seloc0des/godot-settings-menus) — complete, free, no paid tier

**Full versions** — drop-in UI, weight/categories, timed crafting, restock & currencies,
save-aware cross-system integration, and more — are on itch.io:
**https://selodev.itch.io**
