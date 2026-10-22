-- Foreign key of stock_movement (HU-CONCESSIONS-003), kept apart from the CREATE TABLE as Annex A asks.
-- Its index exists already: idx_stock_movement_product_created starts with product_id.
-- No ON DELETE action: a product with history cannot be deleted.
ALTER TABLE concessions.stock_movement
    ADD CONSTRAINT fk_stock_movement_product FOREIGN KEY (product_id)
        REFERENCES concessions.product (id);
