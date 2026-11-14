-- Idempotency of POST /combos (Norma 5.3.8), same mechanism as product_idempotency_key: the combo and
-- the key are written in one transaction; a replay returns the original combo, another payload is a 409.
-- The foreign key to combo is added in 04_alter (V009, Annex A).
CREATE TABLE concessions.combo_idempotency_key (
    key          TEXT        NOT NULL,
    combo_id     UUID        NOT NULL,
    request_hash TEXT        NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT pk_combo_idempotency_key PRIMARY KEY (key),
    CONSTRAINT chk_combo_idempotency_key_length CHECK (char_length(key) BETWEEN 8 AND 128),
    -- One key per combo: the unique index is also the index of the foreign key.
    CONSTRAINT uk_combo_idempotency_key_combo UNIQUE (combo_id)
);

-- The purge of keys older than 24 hours.
CREATE INDEX idx_combo_idempotency_key_created_at ON concessions.combo_idempotency_key (created_at);

GRANT SELECT, INSERT, UPDATE, DELETE ON concessions.combo_idempotency_key TO concessions_writer;
GRANT SELECT ON concessions.combo_idempotency_key TO concessions_reader;
