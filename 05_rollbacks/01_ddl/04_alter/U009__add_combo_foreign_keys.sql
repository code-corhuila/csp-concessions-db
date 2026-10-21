-- Reverts V009.
ALTER TABLE concessions.combo_idempotency_key DROP CONSTRAINT IF EXISTS fk_combo_idempotency_key_combo;
ALTER TABLE concessions.combo_item DROP CONSTRAINT IF EXISTS fk_combo_item_product;
ALTER TABLE concessions.combo_item DROP CONSTRAINT IF EXISTS fk_combo_item_combo;
