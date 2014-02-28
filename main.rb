require "open-uri"
require 'nokogiri'

index_page = Nokogiri::HTML(open("http://apod.nasa.gov/apod/archivepix.html"))

links = index_page.css('a')

links.each do |link|
begin
  naked_link = link['href']
  full_link = "http://apod.nasa.gov/apod/" + naked_link
  individual_page = Nokogiri::HTML(open(full_link))
  image_link = individual_page.css('a')[1]['href']
  url = "http://apod.nasa.gov/apod/" + image_link.to_s
  puts url
  `wget #{url} --directory-prefix=/Users/ianbrody/Desktop/apod-cache/ --continue`
  puts "Downloaded #{url}"
rescue OpenURI::HTTPError => e
  if e.message == '404 Not Found'
    puts "404, moving on."
  else
  end
end
end