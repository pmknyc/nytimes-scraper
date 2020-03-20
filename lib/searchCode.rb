require "pry"

class Search
	attr_accessor 

	@@sections = []

	def initialize
		
	end

	def self.get_sections
		Scraper.scrape_sections
		@@sections
	end

	def search()
		
	end
end
binding.pry