-- A client's snack order (HU-CONCESSIONS-004, ADR-045). It is born RESERVED and ends CONFIRMED or CANCELLED;
-- READY and DELIVERED stay in the list for later stories. reservation_id is a Booking identifier kept for correlation
-- only: no foreign key and no check against Booking (ADR-008). Money is an integer number of cents (Rule 2026-B).
CREATE TABLE concessions.concession_order (
    id              UUID        NOT NULL DEFAULT gen_random_uuid(),
    user_id         UUID        NOT NULL,
    reservation_id  UUID        NULL,
    total_amount    BIGINT      NOT NULL,
    status          TEXT        NOT NULL DEFAULT 'RESERVED',
    idempotency_key TEXT        NOT NULL,
    request_hash    TEXT        NOT NULL,
    expires_at      TIMESTAMPTZ NULL,
    confirmed_at    TIMESTAMPTZ NULL,
    cancelled_at    TIMESTAMPTZ NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT pk_concession_order PRIMARY KEY (id),
    CONSTRAINT chk_concession_order_total_non_negative CHECK (total_amount >= 0),
    CONSTRAINT chk_concession_order_status CHECK (status IN ('PENDING', 'RESERVED', 'CONFIRMED', 'CANCELLED', 'READY', 'DELIVERED')),
    CONSTRAINT chk_concession_order_idempotency_key_length CHECK (char_length(idempotency_key) BETWEEN 8 AND 128),
    -- A retry of POST /orders finds its order by (user, key); the same key of another user is another order.
    CONSTRAINT uk_concession_order_user_key UNIQUE (user_id, idempotency_key)
);

-- One live order per reservation: a cancelled one frees the reservation for a new order.
CREATE UNIQUE INDEX uk_concession_order_live_reservation ON concessions.concession_order (reservation_id)
    WHERE reservation_id IS NOT NULL AND status <> 'CANCELLED';

-- The history of one client, newest first.
CREATE INDEX idx_concession_order_user_created ON concessions.concession_order (user_id, created_at DESC);

-- The sweep of orders without a reservation reads only the RESERVED rows that have a deadline.
CREATE INDEX idx_concession_order_expiration ON concessions.concession_order (expires_at)
    WHERE status = 'RESERVED' AND expires_at IS NOT NULL;

-- The application changes the status but never deletes an order.
GRANT SELECT, INSERT, UPDATE ON concessions.concession_order TO concessions_writer;
GRANT SELECT ON concessions.concession_order TO concessions_reader;
