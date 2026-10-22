# Changelog

## Unreleased

### Added
- `stock_movement` with its checks, idempotency key and index (V010) and its foreign key to `product` in `04_alter` (V011), with their rollbacks, and rebuild CI checks for them (HU-CONCESSIONS-003).
- `combo`, `combo_item` and `combo_idempotency_key` with their rollbacks, and the foreign keys of the combo tables in `04_alter` (V006 to V009, HU-CONCESSIONS-002).
- Rebuild CI checks for the combo constraints.

## HU-CONCESSIONS-001
- Schema `concessions`, its roles and grants, `product` and `product_idempotency_key` (V001 to V005).
