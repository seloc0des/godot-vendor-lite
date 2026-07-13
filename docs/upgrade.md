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

## Migration from Lite

`buy(item, n)` and `sell(item, n)` signatures carry over. The Lite stock Dictionary maps cleanly to a Pro `VendorSettings.stock` entry. Migration is a `class_name` swap plus optionally adopting the `CurrencyResource`-based wallet (your Lite gold wallet still works as a single-currency Pro wallet).

## Where to buy

The full version is on itch.io — **https://selodev.itch.io**. Both tiers share the
same field names and method signatures, so upgrading is a class-name swap.

## License

MIT.
