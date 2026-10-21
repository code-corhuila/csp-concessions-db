# csp-concessions-db

> concessions bounded context: database (schema, seeds, migrations)

Part of the **Cinesync Platform** distributed system — team `cinesync-platform`, Group 1.
Governance and documentation live in [`csp-docs`](https://github.com/code-corhuila/csp-docs).

## Purpose

This repository is the **only owner of the `concessions` schema** of the Cinesync Platform: its structure, seed data,
roles and migrations. `csp-concessions-api` consumes the schema and never versions it (Norma 5.2.1, ADR-018).

## Schema

Every `V<n>` migration has its `U<n>` in `05_rollbacks/`.

| Migration | What it creates |
|---|---|
| `V001` | The schema `concessions` |
| `V002` | The roles `concessions_reader`, `concessions_writer` and `concessions_outbox_reader` (all `NOLOGIN`) |
| `V003` | The grants: `concessions_writer` to the login user `concessions_app`, `concessions_outbox_reader` to `worker_app` |
| `V004` | `product` (HU-CONCESSIONS-001): name, category, price in cents, stock and `DRAFT`/`PUBLISHED`/`INACTIVE` status |
| `V005` | `product_idempotency_key` (one key per product, for the replay of `POST /products`, Norma 5.3.8) |
| `V006` | `combo` (HU-CONCESSIONS-002): name, description, price in cents and `DRAFT`/`PUBLISHED`/`INACTIVE` status |
| `V007` | `combo_item`: one row per component product of a combo, with a positive quantity |
| `V008` | `combo_idempotency_key` (one key per combo, for the replay of `POST /combos`, Norma 5.3.8) |
| `V009` | The foreign keys of the combo tables, in `04_alter` (Annex A) |

Folders follow the families of ADR-013 (`01_ddl` to `05_rollbacks`). The login users are created by
`csp-infra-postgres`; the roles here carry permissions only.

## Run the migrations

The executor `concessions-db-migrate` (`deploy/compose.yml`) joins the `platform` network of `csp-infra-postgres`
and runs before the API starts. Copy `.env.example` to `.env`, fill the values from the platform `.env`, then:

```bash
docker compose -f deploy/compose.yml --profile tooling run --rm concessions-db-migrate
```

Reversion applies the `U` scripts with `psql` from the highest number to the lowest; `U001` refuses to run while
later objects or the roles of `V002` exist.

## Verification

`.github/workflows/db-ci.yml` builds the schema from an empty database, checks that invalid products are refused,
rolls everything back with the `U` scripts and applies the chain again.
