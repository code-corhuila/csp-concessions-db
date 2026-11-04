-- Roles of the concessions domain (ADR-018 and ADR-019). They carry permissions only: NOLOGIN and no password.
-- The login users (concessions_app, worker_app) are created by csp-infra-postgres from secrets.
-- Roles belong to the whole instance, so every name starts with the domain (Annex J).
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'concessions_reader') THEN
    CREATE ROLE concessions_reader NOLOGIN;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'concessions_writer') THEN
    CREATE ROLE concessions_writer NOLOGIN;
  END IF;
  -- Read-only access of csp-worker to concessions.outbox_events (ADR-019). Narrower than concessions_reader on purpose.
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'concessions_outbox_reader') THEN
    CREATE ROLE concessions_outbox_reader NOLOGIN;
  END IF;
END
$$;
