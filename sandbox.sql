BEGIN;
CREATE ROLE pgbouncer_admin WITH LOGIN ENCRYPTED PASSWORD 'password_pgbouncer';
CREATE ROLE user1 WITH LOGIN ENCRYPTED PASSWORD 'password_user1';
CREATE ROLE user2 WITH LOGIN ENCRYPTED PASSWORD 'password_user2';
COMMIT;

CREATE DATABASE sandbox;
\c sandbox

BEGIN;
CREATE TABLE test(value TEXT);
CREATE FUNCTION public.lookup (
    INOUT p_user     name,
    OUT   p_password text
) RETURNS record
    LANGUAGE sql SECURITY DEFINER SET search_path = pg_catalog AS
$$SELECT usename, passwd FROM pg_shadow WHERE usename = p_user$$;
REVOKE EXECUTE ON FUNCTION public.lookup(name) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.lookup(name) TO pgbouncer_admin;
COMMIT;
