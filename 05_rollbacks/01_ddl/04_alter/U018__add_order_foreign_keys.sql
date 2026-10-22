-- Reverts V018.
ALTER TABLE concessions.stock_movement DROP CONSTRAINT IF EXISTS fk_stock_movement_hold;
ALTER TABLE concessions.stock_movement DROP CONSTRAINT IF EXISTS fk_stock_movement_order;
ALTER TABLE concessions.stock_hold_item DROP CONSTRAINT IF EXISTS fk_stock_hold_item_product;
ALTER TABLE concessions.stock_hold_item DROP CONSTRAINT IF EXISTS fk_stock_hold_item_hold;
ALTER TABLE concessions.stock_hold DROP CONSTRAINT IF EXISTS fk_stock_hold_order;
ALTER TABLE concessions.concession_order_item DROP CONSTRAINT IF EXISTS fk_concession_order_item_order;
