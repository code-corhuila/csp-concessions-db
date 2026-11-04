-- Reverts V019.
REVOKE SELECT, INSERT, DELETE ON concessions.inbox_event FROM concessions_writer;
REVOKE SELECT ON concessions.inbox_event FROM concessions_reader;
DROP TABLE IF EXISTS concessions.inbox_event;
