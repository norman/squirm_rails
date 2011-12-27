/*
This is the functions.sql file used by Squirm-Rails. Define your Postgres stored
procedures in this file and they will be loaded at the end of any calls to the
db:schema:load Rake task.
*/

CREATE OR REPLACE FUNCTION hello_world() RETURNS TEXT AS $$
  BEGIN
    RETURN 'hello world!';
  END;
$$ LANGUAGE 'PLPGSQL'
