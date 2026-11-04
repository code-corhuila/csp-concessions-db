-- The product quantities of a hold, with the components of the combos already expanded and added up per product
-- (HU-CONCESSIONS-004, ADR-045). Releasing the hold gives back exactly these quantities.
-- The foreign keys to stock_hold and product are added in 04_alter (V018, Annex A).
CREATE TABLE concessions.stock_hold_item (
    hold_id    UUID NOT NULL,
    product_id UUID NOT NULL,
    quantity   INT  NOT NULL,
    CONSTRAINT pk_stock_hold_item PRIMARY KEY (hold_id, product_id),
    CONSTRAINT chk_stock_hold_item_quantity_positive CHECK (quantity > 0)
);

-- The primary key serves the lookups by hold; this index serves the foreign key to product.
CREATE INDEX idx_stock_hold_item_product_id ON concessions.stock_hold_item (product_id);

GRANT SELECT, INSERT ON concessions.stock_hold_item TO concessions_writer;
GRANT SELECT ON concessions.stock_hold_item TO concessions_reader;
