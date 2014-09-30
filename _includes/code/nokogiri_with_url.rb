require 'nokogiri'
require 'open-uri'

dom=Nokogiri::HTML.parse(open('http://www.xkcd.com'))

all_list_items = dom.css('li')

puts "The number of list items on XKCD's homepage is #{all_list_items.count}"


