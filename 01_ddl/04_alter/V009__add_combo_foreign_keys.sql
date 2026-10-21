-- Foreign keys of the combo tables (HU-CONCESSIONS-002), kept apart from the CREATE TABLE as Annex A asks.
-- Their indexes exist already: the primary key of combo_item (combo_id), idx_combo_item_product_id and
-- uk_combo_idempotency_key_combo.
ALTER TABLE concessions.combo_item
    ADD CONSTRAINT fk_combo_item_combo FOREIGN KEY (combo_id)
        REFERENCES concessions.combo (id) ON DELETE CASCADE;
ALTER TABLE concessions.combo_item
    ADD CONSTRAINT fk_combo_item_product FOREIGN KEY (product_id)
        REFERENCES concessions.product (id);
ALTER TABLE concessions.combo_idempotency_key
    ADD CONSTRAINT fk_combo_idempotency_key_combo FOREIGN KEY (combo_id)
        REFERENCES concessions.combo (id) ON DELETE CASCADE;
