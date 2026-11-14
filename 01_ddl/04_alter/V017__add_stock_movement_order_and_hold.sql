-- The order and the hold that caused a movement (HU-CONCESSIONS-004, ADR-043 and ADR-045). They are null for the
-- receipts and adjustments of HU-CONCESSIONS-003 and set by RESERVE and RELEASE. V010 is applied and frozen, so the
-- columns arrive in a new migration; their foreign keys are in V018. Each foreign key has its own complete index.
ALTER TABLE concessions.stock_movement
    ADD COLUMN order_id UUID NULL,
    ADD COLUMN hold_id  UUID NULL;

CREATE INDEX idx_stock_movement_order_id ON concessions.stock_movement (order_id);
CREATE INDEX idx_stock_movement_hold_id ON concessions.stock_movement (hold_id);
