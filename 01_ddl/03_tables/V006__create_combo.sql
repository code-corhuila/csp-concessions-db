-- A predefined snack-bar bundle sold at one price (HU-CONCESSIONS-002, data-dictionary 06-data).
-- Money is an integer number of cents (Rule 2026-B, ADR-011). The lifecycle is DRAFT -> PUBLISHED -> INACTIVE.
CREATE TABLE concessions.combo (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    name        VARCHAR(160) NOT NULL,
    description VARCHAR(500) NULL,
    price       BIGINT       NOT NULL,
    status      VARCHAR(30)  NOT NULL DEFAULT 'DRAFT',
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    CONSTRAINT pk_combo PRIMARY KEY (id),
    CONSTRAINT chk_combo_name_not_blank CHECK (length(btrim(name)) > 0),
    CONSTRAINT chk_combo_price_non_negative CHECK (price >= 0),
    CONSTRAINT chk_combo_status CHECK (status IN ('DRAFT', 'PUBLISHED', 'INACTIVE'))
);

-- "The name is unique among active rows": a name may be reused only once its earlier combo is INACTIVE.
CREATE UNIQUE INDEX uk_combo_name_active ON concessions.combo (lower(name)) WHERE status <> 'INACTIVE';

-- Client listings read the PUBLISHED rows only.
CREATE INDEX idx_combo_status ON concessions.combo (status);

GRANT SELECT, INSERT, UPDATE ON concessions.combo TO concessions_writer;
GRANT SELECT ON concessions.combo TO concessions_reader;
