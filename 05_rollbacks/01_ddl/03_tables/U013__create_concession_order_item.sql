-- Reverts V013.
REVOKE SELECT, INSERT ON concessions.concession_order_item FROM concessions_writer;
REVOKE SELECT ON concessions.concession_order_item FROM concessions_reader;
DROP TABLE IF EXISTS concessions.concession_order_item;
