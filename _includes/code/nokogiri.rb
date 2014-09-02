require 'nokogiri'

dom=Nokogiri::HTML.parse(File.open('input.html'))

all_list_item = dom.css('li')

puts "The number of list items is #{all_list_items.count}"


