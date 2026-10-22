-- The stock reserved for one order (HU-CONCESSIONS-004, ADR-045). HELD becomes COMMITTED when the order is
-- confirmed or RELEASED when it is cancelled, once, by a conditional update of the status.
-- The foreign key to concession_order is added in 04_alter (V018, Annex A).
CREATE TABLE concessions.stock_hold (
    id          UUID        NOT NULL DEFAULT gen_random_uuid(),
    order_id    UUID        NOT NULL,
    status      TEXT        NOT NULL DEFAULT 'HELD',
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    resolved_at TIMESTAMPTZ NULL,
    CONSTRAINT pk_stock_hold PRIMARY KEY (id),
    CONSTRAINT chk_stock_hold_status CHECK (status IN ('HELD', 'COMMITTED', 'RELEASED')),
    -- One hold per order; this index is also the one of the foreign key to concession_order.
    CONSTRAINT uk_stock_hold_order UNIQUE (order_id)
);

GRANT SELECT, INSERT, UPDATE ON concessions.stock_hold TO concessions_writer;
GRANT SELECT ON concessions.stock_hold TO concessions_reader;
