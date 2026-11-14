-- Reverts V010. Applied after U011.
REVOKE SELECT, INSERT ON concessions.stock_movement FROM concessions_writer;
REVOKE SELECT ON concessions.stock_movement FROM concessions_reader;
DROP TABLE IF EXISTS concessions.stock_movement;
