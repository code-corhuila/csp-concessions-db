-- Reverts V012.
REVOKE SELECT, INSERT, UPDATE ON concessions.concession_order FROM concessions_writer;
REVOKE SELECT ON concessions.concession_order FROM concessions_reader;
DROP TABLE IF EXISTS concessions.concession_order;
