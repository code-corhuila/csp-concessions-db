-- A sellable food or beverage item of the snack bar (HU-CONCESSIONS-001, data-dictionary 06-data).
-- Money is an integer number of cents (Rule 2026-B, ADR-011). The lifecycle is DRAFT -> PUBLISHED -> INACTIVE.
-- gen_random_uuid() is provided by PostgreSQL 16 itself: the schema needs no extension.
CREATE TABLE concessions.product (
    id              UUID         NOT NULL DEFAULT gen_random_uuid(),
    name            VARCHAR(160) NOT NULL,
    description     VARCHAR(500) NULL,
    category        VARCHAR(80)  NOT NULL,
    price           BIGINT       NOT NULL,
    available_stock INT          NOT NULL DEFAULT 0,
    status          VARCHAR(30)  NOT NULL DEFAULT 'DRAFT',
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    CONSTRAINT pk_product PRIMARY KEY (id),
    CONSTRAINT chk_product_name_not_blank CHECK (length(btrim(name)) > 0),
    CONSTRAINT chk_product_price_non_negative CHECK (price >= 0),
    CONSTRAINT chk_product_stock_non_negative CHECK (available_stock >= 0),
    CONSTRAINT chk_product_status CHECK (status IN ('DRAFT', 'PUBLISHED', 'INACTIVE'))
);

-- "The name is unique among active rows": a name may be reused only once its earlier product is INACTIVE.
CREATE UNIQUE INDEX uk_product_name_active ON concessions.product (lower(name)) WHERE status <> 'INACTIVE';

-- Client listings read the PUBLISHED rows only.
CREATE INDEX idx_product_status ON concessions.product (status);

GRANT SELECT, INSERT, UPDATE ON concessions.product TO concessions_writer;
GRANT SELECT ON concessions.product TO concessions_reader;
