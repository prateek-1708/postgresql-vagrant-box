CREATE USER test_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE test_db to test_user;


CREATE TABLE public.test_table
(
  name character varying(255) NOT NULL,
  created_timestamp timestamp without time zone DEFAULT now(),
  CONSTRAINT test_table_pkey PRIMARY KEY (name)
)
WITH (
  OIDS=FALSE
);
