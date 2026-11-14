-- Foreign keys of the order tables (HU-CONCESSIONS-004), kept apart from the CREATE TABLE as Annex A asks.
-- Their indexes exist already: uk_concession_order_item_line and uk_stock_hold_order start with the foreign key
-- column, the primary key of stock_hold_item starts with hold_id, and idx_stock_hold_item_product_id,
-- idx_stock_movement_order_id and idx_stock_movement_hold_id serve the rest.
-- No ON DELETE action: an order, its lines and its hold are history and are never deleted.
ALTER TABLE concessions.concession_order_item
    ADD CONSTRAINT fk_concession_order_item_order FOREIGN KEY (order_id)
        REFERENCES concessions.concession_order (id);
ALTER TABLE concessions.stock_hold
    ADD CONSTRAINT fk_stock_hold_order FOREIGN KEY (order_id)
        REFERENCES concessions.concession_order (id);
ALTER TABLE concessions.stock_hold_item
    ADD CONSTRAINT fk_stock_hold_item_hold FOREIGN KEY (hold_id)
        REFERENCES concessions.stock_hold (id);
ALTER TABLE concessions.stock_hold_item
    ADD CONSTRAINT fk_stock_hold_item_product FOREIGN KEY (product_id)
        REFERENCES concessions.product (id);
ALTER TABLE concessions.stock_movement
    ADD CONSTRAINT fk_stock_movement_order FOREIGN KEY (order_id)
        REFERENCES concessions.concession_order (id);
ALTER TABLE concessions.stock_movement
    ADD CONSTRAINT fk_stock_movement_hold FOREIGN KEY (hold_id)
        REFERENCES concessions.stock_hold (id);
