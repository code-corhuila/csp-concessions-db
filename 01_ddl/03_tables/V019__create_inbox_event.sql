-- Reservation events already applied (ADR-063). csp-worker sends the eventId of BookingConfirmed and ReservationExpired
-- and the API inserts it here in the same transaction as the order change: a delivery whose eventId is already here
-- changes nothing. There is no foreign key: the event may name a reservation that has no order.
CREATE TABLE concessions.inbox_event (
    event_id    UUID         NOT NULL,
    event_type  VARCHAR(100) NOT NULL,
    received_at TIMESTAMPTZ  NOT NULL DEFAULT now(),
    CONSTRAINT pk_inbox_event PRIMARY KEY (event_id),
    CONSTRAINT chk_inbox_event_type CHECK (event_type IN ('BookingConfirmed', 'ReservationExpired'))
);

-- The purge removes the rows older than 30 days (POST /internal/maintenance/purge).
CREATE INDEX idx_inbox_event_received_at ON concessions.inbox_event (received_at);

-- The writer records events and purges old rows, never rewrites one.
GRANT SELECT, INSERT, DELETE ON concessions.inbox_event TO concessions_writer;
GRANT SELECT ON concessions.inbox_event TO concessions_reader;
