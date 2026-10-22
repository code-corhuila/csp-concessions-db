# Changelog

## 3.0.0 - 2026-10-21

First release of `csp-concessions-db` in `main` with the schema of the service.

### Added
- HU-CONCESSIONS-001: schema `concessions`, its `NOLOGIN` roles and grants, `product` and `product_idempotency_key` (V001 to V005, each with its rollback).
- HU-CONCESSIONS-002: `combo`, `combo_item` and `combo_idempotency_key` with their rollbacks, and the foreign keys of the combo tables in `04_alter` (V006 to V009).
- Rebuild CI: applies the chain from an empty database twice, checks that each invalid row is refused, runs the `U` scripts from the highest version down and applies the chain again.
