-- Reverts V008.
REVOKE SELECT, INSERT, UPDATE, DELETE ON concessions.combo_idempotency_key FROM concessions_writer;
REVOKE SELECT ON concessions.combo_idempotency_key FROM concessions_reader;
DROP TABLE IF EXISTS concessions.combo_idempotency_key;
