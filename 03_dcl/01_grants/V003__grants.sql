-- Schema-level grants. Table-level grants are added by the migration that creates each table.
-- csp-concessions-api writes only through concessions_writer, which also reads (it inherits concessions_reader).
GRANT USAGE ON SCHEMA concessions TO concessions_reader, concessions_writer, concessions_outbox_reader;
GRANT concessions_reader TO concessions_writer;

-- The login users already exist: csp-infra-postgres creates them before the migrations run (Annex J.5.5).
GRANT concessions_writer TO concessions_app;
-- csp-worker may only read the outbox (ADR-019). It receives no privilege on any other concessions table.
GRANT concessions_outbox_reader TO worker_app;
