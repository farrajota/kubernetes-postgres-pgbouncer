BEGIN;
CREATE ROLE pgbouncer_admin WITH LOGIN ENCRYPTED PASSWORD 'password_pgbouncer';
COMMIT;

CREATE DATABASE pgbouncer OWNER pgbouncer_admin;
\c pgbouncer

BEGIN;
CREATE FUNCTION public.lookup (
    INOUT p_user     name,
    OUT   p_password text
) RETURNS record
    LANGUAGE sql SECURITY DEFINER SET search_path = pg_catalog AS
$$SELECT usename, passwd FROM pg_shadow WHERE usename = p_user and usename != 'postgres'$$;
REVOKE EXECUTE ON FUNCTION public.lookup(name) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.lookup(name) TO pgbouncer_admin;
COMMIT;
