class NyTimes::Search
	attr_accessor :section_name, :search_term, :section_url, :total_articles

	@@sections = {}#.uniq!.reject! { |item| item.empty?}
	@@search_matches = []
	@@searches = []
	# total_articles = []
	def initialize(section_name, search_term)
		@section_name = section_name
		@search_term = search_term
		@total_articles = 0
		@@searches << self
	end

	def self.searches
		@@searches
	end

	def self.test
		puts "TEST"
	end

	def self.get_sections
		puts "HEY"
		NyTimes::Scraper.scrape_menu
		@@sections
	end

	def self.add_section(section_name, section_url)
		new_section = Hash[section_name, section_url]
		@@sections.merge!(new_section)
		# binding.pry
	end

	def self.sections
		@@sections
	end

	def self.section_names
		@@sections.keys
	end

	def search_overview
		NyTimes::Scraper.scrape_section(section_name, section_url)
		@total_articles
		# binding.pry
	end
end