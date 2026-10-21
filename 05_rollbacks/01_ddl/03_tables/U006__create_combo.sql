-- Reverts V006. Applied after U007, U008 and U009: the combo cannot be dropped while its items point at it.
REVOKE SELECT, INSERT, UPDATE ON concessions.combo FROM concessions_writer;
REVOKE SELECT ON concessions.combo FROM concessions_reader;
DROP TABLE IF EXISTS concessions.combo;
