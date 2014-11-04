require "sqlite3"

# Open a database
db_conn = SQLite3::Database.new "db.sqlite"
db_conn.results_as_hash=true

def run_sql(db_conn, string, *binds)
  stmt=SQLite3::Statement.new db_conn, string
  stmt.bind_params binds
  results=stmt.execute!
  stmt.close
  results
end  

def ratio_target_urls con
  total=count_target_urls con
  crawled=count_crawled_url con
  puts crawled/total.to_f
end

def count_target_urls(db_conn)
  run_sql(db_conn, 'select * from target_urls').size
end
def count_crawled_url(db_conn)
  run_sql(db_conn, 'select * from target_urls where number_of_crawls>0').size
end

def check_dups(db_conn)
  stmt_string1 = "select distinct url from target_urls where url like '%?b=%'"
  stmt = SQLite3::Statement.new(db_conn, stmt_string1);
  all_pg_urls = stmt.execute!
  stmt.close

  stmt_string1 = "select url from target_urls where url like '%?b=%' and number_of_crawls>0"
  stmt = SQLite3::Statement.new(db_conn, stmt_string1);
  crawled_pg_urls = stmt.execute!

  stmt.close

  no_crawls = all_pg_urls.select do |url|

    if !(crawled_pg_urls.include? url)
      results=run_sql(db_conn, 'select * from target_urls where url = ?', url)
      if results.size>1
        puts "#{url} needs correction"
      end
      true
    end
  end
  (all_pg_urls - no_crawls).each do |url|
    puts url
    results = run_sql db_conn, 'delete from target_urls where url = ?', url
  end
end

def update_urls(db_conn)
  stmt_string1 = "select * from target_urls where url like '%b=%'"
  stmt = SQLite3::Statement.new(db_conn, stmt_string1);

  stmt.execute do |set|
    set.each do |row|
      if /\?b=\d+[^\d]/.match row['url']
        puts row['url']
        new_url = row['url'].gsub(/(\?b=\d+)[^\d].+$/, '\1')
        stmt_string = 'update target_urls set url=? where url=?'
        stmt1=SQLite3::Statement.new(db_conn, stmt_string)
        stmt1.bind_params new_url, row['url']

        puts "changing to #{new_url}"
        stmt1.execute
        stmt1.close
      end
    end
  end
  stmt.close
end

#check_dups db_conn

# count_target_urls db_conn

ratio_target_urls db_conn
db_conn.close

