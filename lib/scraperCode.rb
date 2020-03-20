require "open-uri"
require "nokogiri"
require "pry"
require "pry"


class Scraper
	def self.scrape_sections
		html = open("https://www.nytimes.com/")
		doc = Nokogiri::HTML(html)

		#I want to grab the section of the nytimes
		doc.css(".css-1vxc2sl li").each do |li|
			Search::sections << li.css("a").text
		end
	
	# binding.pry
	end

	def method_name
		
	end

end

Scraper.scrape_sections
