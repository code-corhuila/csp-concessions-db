-- Idempotency of POST /products (Norma 5.3.8). The product and the key are written in one
-- transaction with ON CONFLICT DO NOTHING: a replay of the same key returns the original
-- product with 200 and creates nothing, and the same key with another payload answers 409.
CREATE TABLE concessions.product_idempotency_key (
    key          TEXT        NOT NULL,
    product_id   UUID        NOT NULL,
    request_hash TEXT        NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT pk_product_idempotency_key PRIMARY KEY (key),
    CONSTRAINT chk_product_idempotency_key_length CHECK (char_length(key) BETWEEN 8 AND 128),
    -- One key per product: the unique index is also the index of the foreign key.
    CONSTRAINT uk_product_idempotency_key_product UNIQUE (product_id),
    CONSTRAINT fk_product_idempotency_key_product FOREIGN KEY (product_id)
        REFERENCES concessions.product (id) ON DELETE CASCADE
);

-- The purge of keys older than 24 hours.
CREATE INDEX idx_product_idempotency_key_created_at ON concessions.product_idempotency_key (created_at);

GRANT SELECT, INSERT, UPDATE, DELETE ON concessions.product_idempotency_key TO concessions_writer;
GRANT SELECT ON concessions.product_idempotency_key TO concessions_reader;
