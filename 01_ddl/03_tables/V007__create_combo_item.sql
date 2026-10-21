-- The components of a combo: one row per product with a positive quantity (HU-CONCESSIONS-002).
-- The foreign keys to combo and product are added in 04_alter (V009, Annex A).
CREATE TABLE concessions.combo_item (
    combo_id   UUID NOT NULL,
    product_id UUID NOT NULL,
    quantity   INT  NOT NULL,
    CONSTRAINT pk_combo_item PRIMARY KEY (combo_id, product_id),
    CONSTRAINT chk_combo_item_quantity_positive CHECK (quantity > 0)
);

-- The primary key serves the lookups by combo; this index serves the foreign key to product.
CREATE INDEX idx_combo_item_product_id ON concessions.combo_item (product_id);

GRANT SELECT, INSERT, UPDATE, DELETE ON concessions.combo_item TO concessions_writer;
GRANT SELECT ON concessions.combo_item TO concessions_reader;
