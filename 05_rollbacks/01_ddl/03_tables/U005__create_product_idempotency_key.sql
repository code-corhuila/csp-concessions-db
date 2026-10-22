-- Reverts V005. Applied before U004: the product cannot be dropped while its key points at it.
REVOKE SELECT, INSERT, UPDATE, DELETE ON concessions.product_idempotency_key FROM concessions_writer;
REVOKE SELECT ON concessions.product_idempotency_key FROM concessions_reader;
DROP TABLE IF EXISTS concessions.product_idempotency_key;
