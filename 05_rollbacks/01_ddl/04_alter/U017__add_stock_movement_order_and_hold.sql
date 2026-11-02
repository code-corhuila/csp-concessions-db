-- Reverts V017.
DROP INDEX IF EXISTS concessions.idx_stock_movement_hold_id;
DROP INDEX IF EXISTS concessions.idx_stock_movement_order_id;
ALTER TABLE concessions.stock_movement
    DROP COLUMN IF EXISTS hold_id,
    DROP COLUMN IF EXISTS order_id;
