---
layout: post
title: SQL Basics&#58; Understanding Database Queries
categories: beginners-series, back-end
---

In this exercise, we figure out how to create and update data in a database. For this purpose, we will use SQLite3 as our database application.

Note that there are many applications you can use to create your relational databases (_RDBMSes_). The most popular [open source RDBMSes](http://en.wikipedia.org/wiki/List_of_relational_database_management_systems) are probably Postgres, MySQL, CouchDB, and SQLite3. Which one might you use? Well, there are numerous [posts](https://www.digitalocean.com/community/tutorials/sqlite-vs-mysql-vs-postgresql-a-comparison-of-relational-database-management-systems) on [the Web](http://www.databasejournal.com/sqletc/article.php/3486596/Open-Source-Databases-A-brief-look-at-the-Berkeley-DB-Derby-Firebird-Ingres-MySQL-and-PostgreSQL-DBMS.htm) that [attempt to answer](http://stackoverflow.com/questions/1635273/postgres-vs-firebird) that very question! 

Popular paid RDBMS apps include Microsoft's SQL Server and Oracle Corp's Oracle suite of RDBMS.

So what should you pick? We think that as a beginner, you won't find yourself facing the kind of choices that are talked
about here, and using SQLite3 might be your best option, wining as it does on simplicity. The advantage of SQLite3 over
all other open source RDBMS applications is that the database is stored directly on a single file in your machine -
other applications require the setup of an intermediate "database server" that interacts with a much more complicated
file structure to store your data.

# Tables and Columns

The simplest idea to know about building a database is that it contains tables, and those tables have columns. If you
have no familiarity with databases, it might be useful to think of it as a spreadsheet, with each worksheet in your
spreadsheet as a _table_, and each column in a specific worksheet as a _column_ in that table.

Columns in database tables are required to be described by at least two pieces of information:

* A name (which you can think of as a _column header_)
* A _data type_

Why a data type? This is usually for space and other efficiency considerations. Here's [an old-ish but good post that describes some of these considerations](http://www.brandonsavage.net/designing-databases-picking-the-right-data-types/), and another that lists [common data types that RDBMSes will support](http://www.w3schools.com/sql/sql_datatypes_general.asp).

Data types are important for you to think about, even in beginners' apps. Be aware at least of the following types:

* _string_ and _text_, and the distinction between the two. Both are for storing textual data, but _string_ data types are used when the data is known to have a limit (usually, around 256 characters in a database.)
* _integer_ and _float_: When your data is guaranteed to be numeric
* _boolean_: When the data value is [Boolean](http://en.wikipedia.org/wiki/Boolean_data_type), that is - either `true` or `false`
* _datetime_: When the data value represents a date (but _not_ just a number representing seconds or minutes, specifically it is a very specific date on the calendar, complete with year.) _datetime_ values are represented using a specific format, called the *POSIX date* format, which looks like "2014-07-04 07:43:12PM PST"

## Talking to the Database

SQL is the language you use to communicate with the database. Anything you do with a database requires constructing SQL to do it.

Note that all SQL commands have to end with a semicolon - `;`

To create a table, for example, you send the following SQL command to a database

    CREATE TABLE table_name COLUMNS (col_name_1 type1, col_name_2 type2);

It's customary to show SQL-specific commands, like `CREATE` and `COLUMNS` in uppercase and names of things like columns and types in lower-case. However, most RDBMS apps don't differentiate between lowercase and uppercase.

To add columns to an existing table, you would use the following SQL command:

    ALTER TABLE table_name ADD COLUMN new_col_name new_col_type;

# The Ruby SQLite3 Gem

When using the SQLite3 gem to communicate with a database, the process of communicating with a database is often broken down into two parts:

* Making a connection to the database, which usually happens once at the start of the application or script
* Preparing a _statement_ via the connection
* _Executing_ the statement

## Making a connection

To make a connection, you usually need some identifier that locates the database. In the case of SQLite3, that identifier is simply the name of the file that stores the database:

    require "sqlite3"
    db_conn = SQLite3::Database.new "test.db"

Here, the filename is `test.db` - if it exists, then a connection is made to the database that's in that file; else, a new file is created and all subsequent commands sent to this connection object (`db_conn`) will write data into this file. 

## Queries and Bindings

A query, aka _DB statements_, or _DB queries_, will typically contain values that are being inserted into, or updated
in, the database. Binding is the process by which you take a template DB statement, which has _placeholders_ for the values you want to insert, and assign the values to those placeholders. Placeholders are noted by the `?` symbol. The process for doing this in the Ruby gem is as follows:

    values = [{title: 'Post title', body: 'This is a post.',  date:'2014-04-01 14:35:00'},
              {title: 'Another post', body: 'Another post I wrote.',  date:'2014-05-11 07:12:34'}]
    
    values.each do |row|
      stmt = SQLite3::Statement.new(db_conn, "INSERT INTO  posts (title, body, date_written) values (?, ?, ?)")
      stmt.bind_params(row[:title], row[:body], row[:date])
      stmt.execute 
      stmt.close
    end

Here, we go through four steps for each insertion into the database:

1. _Prepare_ the statement, by telling it which database it will operate on.
1. _Bind_ it to the specific values we are inserting. This step, also called "sanitizing queries," removes certain common security issues that arise when creating database queries - you can read more on this blog about [query placeholders and binding and why it's important](http://zetcode.com/db/sqliteruby/bind/). When queries are not sanitized, [they make your system vulnerable to "SQL injection."](http://security.stackexchange.com/questions/25684/how-can-i-explain-sql-injection-without-technical-jargon)
1. Execute it
1. Close it

It's "[good coding hygiene](http://bclennox.com/code-hygiene)" to _close_ statements and database connections. It's somewhat like ejecting a USB device from your computer before pulling the cord out.

To gain a deeper understanding of SQL, read through the MySQL reference manual listed in the References section.

# Homework

1. Based on the explanation of sanitization and injection, [explain this joke](http://xkcd.com/327/).

# References

* [W3 Schools section on SQL commands](http://www.w3schools.com/sql/)
* [MySQL Reference Manual](http://dev.mysql.com/doc/refman/5.7/en/) - v 5.7 as of the writing of this text book.
* [POSIX date format reference]()