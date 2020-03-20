class NyTimes::Search
	attr_accessor :section_name, :search_term, :section_url, :search_matches, :article_sub_urls #:total_hits

	@@sections = {}#.uniq!.reject! { |item| item.empty?}
	@@searches = []
	# total_articles = []
	def initialize(section_name, search_term)
		@section_name = section_name
		@search_term = search_term
		@article_sub_urls = []
		# @total_hits = 0
		@search_matches = []
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

	def search_section
		NyTimes::Scraper.scrape_section(section_name, section_url)
	end


end