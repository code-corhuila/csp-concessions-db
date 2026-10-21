-- Reverts V007.
REVOKE SELECT, INSERT, UPDATE, DELETE ON concessions.combo_item FROM concessions_writer;
REVOKE SELECT ON concessions.combo_item FROM concessions_reader;
DROP TABLE IF EXISTS concessions.combo_item;
