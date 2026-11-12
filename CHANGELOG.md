# Changelog

## 1.3.4 (2026-10-24)

The shop panel gives you the mouse in a third-person game.

- **Opening a shop frees the mouse in a third-person game.** The orbit camera from Controller (Pro)
  1.6.0, which holds the mouse for looking around, now lets go of it while the shop panel is on
  screen, so you can click Buy and Sell. When you close the shop, the next click in the game takes
  the mouse back. Nothing to set up, and games without that camera behave as before.

## 1.3.3 (2026-10-12)

The tabs show their names on Godot 4.5.

- **The Vendor · Setup tab was blank on Godot 4.5.** Its tab beside the Inspector had no title, so
  "open the Vendor · Setup tab" pointed at nothing. It is named when the pack switches on now. Godot
  4.7 was not affected.

## 1.3.2 (2026-09-28)

No warning after New item.

- **No "invalid UID" warning on the first Play after New item.** Godot hadn't registered the new
  file yet, which put a yellow Debugger badge on screen.

## 1.3.1 (2026-09-27)

Both tabs fit a default dock.

- **The Setup and authoring tabs fit a default dock.** A tab taller than the dock scrolls, and lists
  show what you just made the next time they open. Price and Buys back each get a line in a stock
  row.

## 1.3.0 (2026-09-27)

A shop you can use without writing code.

- **A shop panel with no code.** Walking up to a shopkeeper opens it: the stock with Buy buttons,
  the player's gold and a Sell list. Walking away or Close shuts it, and a purchase that can't
  happen says why.
- **Stock is edited as rows** on the Setup tab: pick the item from a list, set its price, what the
  shop buys it back for and how many it has (or No limit). New item makes one for you. Nobody
  types dictionary keys in the Inspector any more.
- **Buying with a full bag gives the gold back.** It used to keep the money.
- The shop finds the player's wallet and bag by itself. The Wallet Path and Inventory Path fields
  still override.
- **"Give the player a wallet" marks the node as the player**, and pressing Apply twice in a row
  keeps that mark on the player.
- **A wallet on the scene root is its own.** Applying one to the root used to take over a
  shopkeeper's wallet further down the tree, and the same went for a shop on a parent node.
- Four example items in the demo.
- **Pressing Play right after Apply includes what it added.** The Setup tab never marked the scene
  as changed, so Play ran the saved version without it.
- **The shop and wallet are added the way a node you add by hand is**, so their game code doesn't
  run in the editor.
- **Nodes the Setup tab adds get readable names.** A second one under the same parent is
  called something like `UILayer2`, instead of a generated name full of `@` signs.

## 1.2.0 (2026-08-22)

- Engine floor moves to Godot 4.5. The project and the plugin description both
  said 4.3 before, which no longer matched the code.
- The addon and its docs now say selodev throughout. The old CindieForge name
  was still in the README and the upgrade notes after the rebrand.

## 1.1.0 — 2026-07-24

One-click no-code setup.

- New **Vendor · Setup** panel (the first dock tab): pick the outcome you want → **Apply** → the Lite component is added to your scene, baked in and re-editable.
- Pro unlocks the full no-code wiring — gameplay triggers, bound UI, and cross-system hooks.

## 1.0.0 — 2026-06-01

Initial release.

- `WalletLite` Node — single currency, `add` / `subtract` / `has_amount` / `get_balance` / `set_balance`.
- `VendorLite` Node — stock array, `buy(item, n)` / `sell(item, n)`, rejection reasons.
- Stock entry shape: `{item, price, stock, sell_price?}`. `stock = -1` means unlimited.
- Signals: `purchase_completed`, `sale_completed`, `transaction_rejected`, `stock_changed`, `balance_changed`.
- Demo: 4-item shop, +50 gold button, live buy/sell with status flashes.
