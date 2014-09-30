require 'nokogiri'

dom=Nokogiri::HTML.parse(File.open('input.html'))

all_list_items = dom.css('li')

puts "The number of list items is #{all_list_items.count}"


