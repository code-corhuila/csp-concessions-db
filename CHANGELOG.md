# Changelog

## Unreleased

### Added
- `concession_order`, `concession_order_item`, `stock_hold`, `stock_hold_item` and `outbox_event` (V012 to V016), `order_id` and `hold_id` on `stock_movement` (V017) and the foreign keys of all of them in `04_alter` (V018), with their rollbacks (U012 to U018), and rebuild CI checks for their constraints, grants and foreign key indexes (HU-CONCESSIONS-004).
- `stock_movement` with its checks, idempotency key and index (V010) and its foreign key to `product` in `04_alter` (V011), with their rollbacks, and rebuild CI checks for them (HU-CONCESSIONS-003).
- `combo`, `combo_item` and `combo_idempotency_key` with their rollbacks, and the foreign keys of the combo tables in `04_alter` (V006 to V009, HU-CONCESSIONS-002).
- Rebuild CI checks for the combo constraints.

## HU-CONCESSIONS-001
- Schema `concessions`, its roles and grants, `product` and `product_idempotency_key` (V001 to V005).
