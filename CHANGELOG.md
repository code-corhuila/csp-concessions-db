# Changelog

## 3.0.0 - 2026-10-21

First release of `csp-concessions-db` in `main` with the schema of the service.

### Added
- HU-CONCESSIONS-001: schema `concessions`, its `NOLOGIN` roles and grants, `product` and `product_idempotency_key` (V001 to V005, each with its rollback).
- HU-CONCESSIONS-002: `combo`, `combo_item` and `combo_idempotency_key` with their rollbacks, and the foreign keys of the combo tables in `04_alter` (V006 to V009).
- Rebuild CI: applies the chain from an empty database twice, checks that each invalid row is refused, runs the `U` scripts from the highest version down and applies the chain again.
- HU-CONCESSIONS-003: `stock_movement` (immutable audit trail of the stock of a product) with its checks, idempotency key and index (V010) and its foreign key to `product` in `04_alter` (V011), with their rollbacks, and rebuild CI checks for the constraints, the key, the foreign key and the privileges.
- HU-CONCESSIONS-004: `concession_order`, `concession_order_item`, `stock_hold`, `stock_hold_item` and `outbox_event` (V012 to V016), `order_id` and `hold_id` on `stock_movement` (V017) and the foreign keys of all of them in `04_alter` (V018), with their rollbacks (U012 to U018), and rebuild CI checks for their constraints, grants and foreign key indexes (HU-CONCESSIONS-004).
- HU-CONCESSIONS-005: `inbox_event` (V019, rollback U019) keyed by the `eventId` of the Booking events already applied, with its CI checks (ADR-063).
