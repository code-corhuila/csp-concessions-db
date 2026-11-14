-- Immutable audit trail of the stock of a product (HU-CONCESSIONS-003, ADR-043). The balance itself stays in
-- product.available_stock; every change to it leaves one row here, written in the same transaction.
-- The foreign key to product is added in 04_alter (V011, Annex A). order_id and hold_id are added by HU-CONCESSIONS-004.
CREATE TABLE concessions.stock_movement (
    id              UUID        NOT NULL DEFAULT gen_random_uuid(),
    product_id      UUID        NOT NULL,
    quantity_delta  INT         NOT NULL,
    balance_after   INT         NOT NULL,
    movement_type   TEXT        NOT NULL,
    idempotency_key TEXT        NULL,
    created_by      UUID        NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT pk_stock_movement PRIMARY KEY (id),
    CONSTRAINT chk_stock_movement_delta_not_zero CHECK (quantity_delta <> 0),
    CONSTRAINT chk_stock_movement_balance_non_negative CHECK (balance_after >= 0),
    CONSTRAINT chk_stock_movement_type CHECK (movement_type IN ('RECEIPT', 'ADJUSTMENT', 'RESERVE', 'RELEASE', 'CONSUME')),
    CONSTRAINT chk_stock_movement_idempotency_key_length CHECK (char_length(idempotency_key) BETWEEN 8 AND 128),
    -- A retry of POST /stock/adjust finds its movement by the key; movements without a key never collide.
    CONSTRAINT uk_stock_movement_idempotency_key UNIQUE (idempotency_key)
);

-- The history of one product in order; its first column is also the index of the foreign key to product.
CREATE INDEX idx_stock_movement_product_created ON concessions.stock_movement (product_id, created_at);

-- The application can add rows and read them, never change or delete one: the trail is immutable.
GRANT SELECT, INSERT ON concessions.stock_movement TO concessions_writer;
GRANT SELECT ON concessions.stock_movement TO concessions_reader;
