# Vendor (Lite)

**FREE.** Single-currency vendor/shop for Godot 4.5+. Pure GDScript. MIT.

The working core of the [selodev Vendor addon](docs/upgrade.md). One `WalletLite` for currency, one `VendorLite` for the shop, and a plain `ShopPanelLite` window that opens when the player walks up.

## One-click setup (no code)

Enable the plugin and a **Vendor · Setup** tab appears in the editor. Pick an outcome, choose where it goes and press **Apply**. What it adds is baked into your scene and stays editable. Apply again and it updates in place.

- **A shop / vendor** adds a `VendorLite` to the selected node (your shopkeeper), a `ShopArea` around it and a hidden `ShopPanel` on a UI layer. On Play the panel opens in the lower middle of the screen when the player walks into the ShopArea, and closes when they walk away or press **Close**. If the node is already an area with a collision shape, the panel opens from that area instead.
- **Give the player a wallet** adds a `WalletLite` to your player and marks that node as the player, so the shop (and touch triggers from other packs) find it.
- **Shop + wallet (working pair)** adds a shop with its own wallet beside it. The shop takes payment from that wallet instead of the player's, which is handy for a quick test.

Under **3. What does the shop sell?** the tab shows the selected shop's stock as rows. **Add row** adds one: pick the item (your own from `res://items` first, then the demo's as examples), set the **Price**, what the shop **Buys back** the item for, and a **Stock** count or **No limit**. **New item** makes an item in `res://items`, puts it on a new row and opens it in the Inspector, so you can name it and pick an icon. The rows follow whichever shop you select.

The panel lists the stock with a **Buy** button per item, the player's money, and a **Sell** list of the items in the player's bag that the shop buys. A button greys out when the player can't afford the item or it's sold out, and a turned-down purchase shows the reason, for example "Your bag is full." The panel finds the player's wallet and bag on Play through the "player" group, so there's nothing to link by hand.

The status line under **Apply** says what's still missing. If nothing is marked as the player yet, select your player and press **Make the selected node the player**.

The player needs a bag for what they buy. The **Inventory · Setup** tab of Inventory (Lite) adds one (**Player inventory**). Any node with `add_item`, `remove_item` and `count_item` works.

## 5-minute install

1. Copy `addons/vendor_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Vendor (Lite)**.
3. Select your player, pick **Give the player a wallet**, set **Starting balance** and press **Apply**.
4. Select your shopkeeper, pick **A shop / vendor** and press **Apply**.
5. Under **3. What does the shop sell?** press **Add row** for each item and fill in the item, **Price**, **Buys back** and **Stock** (or tick **No limit**). **New item** makes an item if you have none yet.
6. Save and press Play. Walk into the shop.

### From code (optional)

```gdscript
vendor.stock = [
    {"item": apple, "price": 5, "stock": 20, "sell_price": 2},
    {"item": ring,  "price": 300, "stock": -1, "sell_price": 120},  # -1 stock = unlimited
]
vendor.buy(apple, 3)       # subtracts 15g, adds 3 apples to the bag, decrements stock
vendor.sell(old_sword, 1)  # adds the sword's sell_price to the wallet, removes it from the bag
```

Bind the wallet and bag with `bind_wallet` / `bind_inventory` (or Wallet Path / Inventory Path in the Inspector), or call `vendor.link_player()` to use the ones on the "player" group's node. The panel calls it for you when it opens.

## What's missing (and why)

| Feature | Tier |
|---|---|
| Multi-currency wallets (gold + gems + …) | Full version |
| Buyback ratio (auto-derive sell from buy price) | Full version |
| Restock timers (`restock_seconds`) | Full version |
| Conditional offers (flag / level / quest gating) | Full version |
| Timed offers (`available_until` deadlines) | Full version |
| Category-only sell-back filtering | Full version |
| Styled `ShopUI` with icons, Buy/Sell tabs and a wallet bar | Full version |
| Save-contract auto-join + shared `Events` bus | Full version |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


## Part of a family

This is one free tier from the selodev catalog of no-code Godot 4 systems. They share an item contract and a save contract, so they plug into each other, and each one also works fully on its own.

Free systems:

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite)
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite)
- [Loot Lite](https://github.com/seloc0des/godot-loot-lite)
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite)
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite)
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite)
- [Stats / Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite)
- [Save / Load Lite](https://github.com/seloc0des/godot-save-load-lite)
- [Dialogue Lite](https://github.com/seloc0des/godot-dialogue-lite)
- [Combat Lite](https://github.com/seloc0des/godot-combat-lite)
- [Controller Lite](https://github.com/seloc0des/godot-controller-lite)
- [Enemy AI Lite](https://github.com/seloc0des/godot-enemy-ai-lite)
- [Scene Flow Lite](https://github.com/seloc0des/godot-scene-flow-lite)
- [Audio Lite](https://github.com/seloc0des/godot-audio-lite)
- [Level Builder Lite](https://github.com/seloc0des/godot-level-builder-lite)
- [Weather System Lite](https://github.com/seloc0des/godot-weather-lite)
- [Settings + Menus](https://github.com/seloc0des/godot-settings-menus) (complete and free, no paid tier)

Free VFX: [Magic Cast](https://github.com/seloc0des/godot-magic-cast-vfx-lite), [Elemental Impact](https://github.com/seloc0des/godot-elemental-impact-vfx-lite), [Explosion](https://github.com/seloc0des/godot-explosion-vfx-lite), [Pickup, Buff & Heal](https://github.com/seloc0des/godot-pickup-buff-vfx-lite).

Free starter projects: [Free Starter](https://github.com/seloc0des/free-starter-godot), [Dungeon](https://github.com/seloc0des/godot-dungeon-starter), [Survival](https://github.com/seloc0des/godot-survival-starter), [RPG](https://github.com/seloc0des/godot-rpg-starter).

The [full versions](https://selodev.itch.io/vendor-shop-no-code-trading-for-godot-4) add drop-in UI, editor docks and the cross-system wiring. They're on itch.io: **https://selodev.itch.io**
