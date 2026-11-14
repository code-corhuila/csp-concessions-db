-- Reverts V014.
REVOKE SELECT, INSERT, UPDATE ON concessions.stock_hold FROM concessions_writer;
REVOKE SELECT ON concessions.stock_hold FROM concessions_reader;
DROP TABLE IF EXISTS concessions.stock_hold;
