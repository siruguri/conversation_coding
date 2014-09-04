require "sqlite3"

# Open a database
db_conn = SQLite3::Database.new "test.db"

stmt = SQLite3::Statement.new(db_conn, "CREATE  TABLE if not exists posts (title string, body text, date_written datetime)")
stmt.execute 
stmt.close

values = [{title: 'Post title', body: 'This is a post.',  date:'2014-04-01 14:35:00'},
          {title: 'Another post', body: 'Another post I wrote.',  date:'2014-05-11 07:12:34'}]

values.each do |row|
  stmt = SQLite3::Statement.new(db_conn, "INSERT INTO  posts (title, body, date_written) values (?, ?, ?)")
  stmt.bind_params(row[:title], row[:body], row[:date])
  stmt.execute 
  stmt.close
end

db_conn.close
