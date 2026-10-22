-- The lines of an order with the name and unit price copied when it was created (HU-CONCESSIONS-004, ADR-045).
-- item_id is a product or a combo of this service; the type says which, so there is no foreign key to either.
-- The foreign key to concession_order is added in 04_alter (V018, Annex A).
CREATE TABLE concessions.concession_order_item (
    id                  UUID         NOT NULL DEFAULT gen_random_uuid(),
    order_id            UUID         NOT NULL,
    item_type           TEXT         NOT NULL,
    item_id             UUID         NOT NULL,
    item_name_snapshot  VARCHAR(160) NOT NULL,
    unit_price_snapshot BIGINT       NOT NULL,
    quantity            INT          NOT NULL,
    CONSTRAINT pk_concession_order_item PRIMARY KEY (id),
    CONSTRAINT chk_concession_order_item_type CHECK (item_type IN ('PRODUCT', 'COMBO')),
    CONSTRAINT chk_concession_order_item_price_non_negative CHECK (unit_price_snapshot >= 0),
    CONSTRAINT chk_concession_order_item_quantity_positive CHECK (quantity > 0),
    -- The same line cannot appear twice; its first column is also the index of the foreign key to concession_order.
    CONSTRAINT uk_concession_order_item_line UNIQUE (order_id, item_type, item_id)
);

-- The snapshot never changes: the application can add lines and read them.
GRANT SELECT, INSERT ON concessions.concession_order_item TO concessions_writer;
GRANT SELECT ON concessions.concession_order_item TO concessions_reader;
