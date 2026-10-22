-- Events of the domain, written in the same transaction as the change (Norma 5.3.11, ADR-045). It has the shape of
-- the Booking outbox, which is the one csp-worker reads: id is the eventId and payload the full envelope. There is no
-- processed_at (ADR-019): csp-worker keeps the publication state in its own schema and reads this table with SELECT only.
CREATE TABLE concessions.outbox_event (
    id             UUID         NOT NULL DEFAULT gen_random_uuid(),
    aggregate_type VARCHAR(100) NOT NULL,
    aggregate_id   UUID         NOT NULL,
    event_type     VARCHAR(100) NOT NULL,
    payload        JSONB        NOT NULL,
    created_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),
    CONSTRAINT pk_outbox_event PRIMARY KEY (id)
);

-- The relay reads in order of creation.
CREATE INDEX idx_outbox_event_created_at ON concessions.outbox_event (created_at, id);

-- The writer appends and purges old rows (POST /internal/maintenance/purge), never rewrites one.
GRANT SELECT, INSERT, DELETE ON concessions.outbox_event TO concessions_writer;
GRANT SELECT ON concessions.outbox_event TO concessions_reader;
-- csp-worker may read this table and nothing else of the schema (ADR-019).
GRANT SELECT ON concessions.outbox_event TO concessions_outbox_reader;
