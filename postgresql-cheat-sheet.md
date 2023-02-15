# PostgreSQL cheat sheet

For development purposes use PostgreSQL. There are multiple ways to run it. The easiest:

```bash

docker run -p 5432:5432 -d -e POSTGRES_PASSWORD=secret postgres

psql -h localhost -p 5432 -U postgres # type `secret` for password


postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# create database mydb;
CREATE DATABASE

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 mydb      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

postgres=# \c mydb;
psql (13.6, server 15.2 (Debian 15.2-1.pgdg110+1))
WARNING: psql major version 13, server major version 15.
         Some psql features might not work.
You are now connected to database "mydb" as user "postgres".
mydb=# 
\q

```

Now let's seed some data in it:

```bash

DROP DATABASE abw_db;
CREATE DATABASE abw_db;
\c abw_db;

DROP TABLE IF EXISTS books;

CREATE TABLE public.books (
    id serial PRIMARY KEY,
    title character varying(150) NOT NULL,
    author character varying(50) NOT NULL,
    pages_num integer NOT NULL,
    read boolean NOT NULL,
    date_added date DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO books (title, author, pages_num, read)
            VALUES ('The Phoenix Projecy','Gene Kim, Kevin Behr and George Spafford',431,True);

INSERT INTO books (title, author, pages_num, read)
            VALUES ('Coders','Clive Thompson',436,False);

INSERT INTO books (title, author, pages_num, read)
            VALUES ('Mindware: Tools for Smart Thinking','Richard E. Nisbett',336,False);

```

Validate either everything has been created successfully:

```bash

abw_db=# \c abw_db;
You are now connected to database "abw_db" as user "postgres".
abw_db=# SELECT * FROM books;
 id |               title                |                  author                  | pages_num | read | date_added 
----+------------------------------------+------------------------------------------+-----------+------+------------
  1 | The Phoenix Projecy                | Gene Kim, Kevin Behr and George Spafford |       431 | t    | 2022-04-28
  2 | Coders                             | Clive Thompson                           |       436 | f    | 2022-04-28
  3 | Mindware: Tools for Smart Thinking | Richard E. Nisbett                       |       336 | f    | 2022-04-28
(3 rows)

abw_db=# 

```

Backup and restore:

```bash

# dump db to file

pg_dump -h localhost -U postgres abw_db > abw_db.sql

# restore db from file

psql sslmode=<mode> -h <host> -U <user> -f abw_db.sql postgres -d postgres

# sslmode can be either require or prefer

```

That's it! 🐘