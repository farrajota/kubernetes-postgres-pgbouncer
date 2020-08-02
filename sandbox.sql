BEGIN;
CREATE ROLE pgbouncer_admin WITH LOGIN ENCRYPTED PASSWORD 'password_pgbouncer';
CREATE ROLE user1 WITH LOGIN ENCRYPTED PASSWORD 'password_user1';
COMMIT;

CREATE DATABASE sandbox;
\c sandbox

BEGIN;
CREATE TABLE test(value TEXT);
GRANT ALL on TABLE test TO user1;
CREATE FUNCTION public.lookup (
    INOUT p_user     name,
    OUT   p_password text
) RETURNS record
    LANGUAGE sql SECURITY DEFINER SET search_path = pg_catalog AS
$$SELECT usename, passwd FROM pg_shadow WHERE usename = p_user$$;
REVOKE EXECUTE ON FUNCTION public.lookup(name) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.lookup(name) TO pgbouncer_admin;
COMMIT;
