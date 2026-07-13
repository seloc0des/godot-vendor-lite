# Changelog

## 1.0.0 — 2026-06-01

Initial release.

- `WalletLite` Node — single currency, `add` / `subtract` / `has_amount` / `get_balance` / `set_balance`.
- `VendorLite` Node — stock array, `buy(item, n)` / `sell(item, n)`, rejection reasons.
- Stock entry shape: `{item, price, stock, sell_price?}`. `stock = -1` means unlimited.
- Signals: `purchase_completed`, `sale_completed`, `transaction_rejected`, `stock_changed`, `balance_changed`.
- Demo: 4-item shop, +50 gold button, live buy/sell with status flashes.
