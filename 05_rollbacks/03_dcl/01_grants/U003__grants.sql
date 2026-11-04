-- Reverts V003. Applied before U002 (roles) and U001 (schema), from the highest version down.
REVOKE concessions_outbox_reader FROM worker_app;
REVOKE concessions_writer FROM concessions_app;
REVOKE concessions_reader FROM concessions_writer;
REVOKE USAGE ON SCHEMA concessions FROM concessions_reader, concessions_writer, concessions_outbox_reader;
