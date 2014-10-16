require 'nokogiri'
require 'open-uri'

dom=Nokogiri::HTML.parse(open('http://www.reddit.com/r/rails/new/'))
require "sqlite3"

# Open a database
db_conn = SQLite3::Database.new "test.db"
db_conn.results_as_hash=true

stmt = SQLite3::Statement.new(db_conn, "CREATE  TABLE if not exists posts (title string, author_name text, date_posted datetime, category string, num_comments integer)")
stmt.execute 
stmt.close

all_posts = dom.css('.entry')

puts "The number of posts is #{all_posts.count}"
all_posts.each do |post|
  title_node = post.css('a.title')
  timestamp = post.css('.live-timestamp')
  author_node = post.css('a.author')
  author_name = author_node.text
  post_time = timestamp.attr('datetime').to_s

  cat_name = post.css('span.domain a').text

  comments_node = post.css('a.comments')
  num_of_comments = comments_node.text.to_i

  puts "Title: #{title_node.text}, posted by #{author_name} at #{timestamp.attr('datetime')} into #{cat_name} with #{num_of_comments} comments"


  found_post=false

  stmt = SQLite3::Statement.new(db_conn, "select * from posts where title=?")
  stmt.bind_params title_node.text
  rows=stmt.execute

  found_post = (rows.count > 0)
  stmt.close
  
  if(!found_post)
    stmt = SQLite3::Statement.\
    new( \
         db_conn,\
         "INSERT INTO  posts (title, author_name, date_posted, category, num_comments) values (?, ?, ?, ?, ?)")
    stmt.bind_params(title_node.text, author_name, post_time, cat_name, num_of_comments)
    stmt.execute 
    stmt.close
  else
    puts "Already have a row with that title."
  end

end


db_conn.close
