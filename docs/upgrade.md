# Upgrade to Vendor (Pro)

## What Pro adds

- **Multi-currency wallets.** `WalletComponent` holds any number of currencies. `CurrencyResource` Resources define icon, color, format template per currency. Vendors can price in gold + gems simultaneously.
- **`VendorSettings` Resource.** Author stock entries as a Resource, not a runtime Array. Each entry has item, stock, max_stock, price (multi-currency), buyback_ratio, restock_seconds, available_until, condition.
- **Buyback ratio.** Set once per vendor — sell prices derive from buy prices automatically.
- **Restock timers.** Stock ticks back up to `max_stock` on a schedule.
- **Conditional offers.** Offer only available when a flag is set, a stat is above a threshold, a quest is complete.
- **Timed offers.** `available_until` deadline — the vendor displays a countdown.
- **Category gating.** "This vendor only buys junk." "This vendor only sells weapons."
- **Drop-in `ShopUI` Control.** Buy and Sell tabs, wallet bar, per-row stock counts, themed.
- **Save-contract auto-join.** Stock state and restock timers persist.
- **Shared `Events` autoload.** `purchase_completed`, `sale_completed`, `transaction_rejected`, `vendor_restocked`, `currency_changed`.

## Moving from Lite

The full version installs next to the Lite, in its own folder, and both run in the same project, so you can move over one piece at a time. It isn't a drop-in replacement: the class names differ, and so do some method names.

`VendorLite` becomes `VendorComponent`, and `WalletLite` becomes `WalletComponent`. `buy` and `sell` keep their names. The Lite's `bind_inventory`, `bind_wallet`, `get_price`, `get_stock` and the other `get_*` helpers don't exist in the full version, so code that calls them needs rewriting. Set the stock up again in the full version.

## Where to buy

The full version is on itch.io: **https://selodev.itch.io**.

## License

MIT.
