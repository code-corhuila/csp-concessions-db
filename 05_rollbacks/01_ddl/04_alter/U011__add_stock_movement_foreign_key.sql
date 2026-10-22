-- Reverts V011.
ALTER TABLE concessions.stock_movement DROP CONSTRAINT IF EXISTS fk_stock_movement_product;
