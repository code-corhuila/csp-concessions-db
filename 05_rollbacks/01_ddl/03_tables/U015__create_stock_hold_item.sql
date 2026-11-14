-- Reverts V015.
REVOKE SELECT, INSERT ON concessions.stock_hold_item FROM concessions_writer;
REVOKE SELECT ON concessions.stock_hold_item FROM concessions_reader;
DROP TABLE IF EXISTS concessions.stock_hold_item;
