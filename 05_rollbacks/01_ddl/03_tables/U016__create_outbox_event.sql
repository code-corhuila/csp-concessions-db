-- Reverts V016.
REVOKE SELECT ON concessions.outbox_event FROM concessions_outbox_reader;
REVOKE SELECT, INSERT, DELETE ON concessions.outbox_event FROM concessions_writer;
REVOKE SELECT ON concessions.outbox_event FROM concessions_reader;
DROP TABLE IF EXISTS concessions.outbox_event;
