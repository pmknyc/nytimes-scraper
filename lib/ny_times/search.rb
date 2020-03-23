class NyTimes::Search
	attr_accessor :section_name, :search_term, :section_url, :search_matches, :article_sub_urls, :recency_in_days

	@@sections = {"FRONT PAGE" => "https://www.nytimes.com/"}#.uniq!.reject! { |item| item.empty?}
	@@searches = []
	def initialize(section_name, search_term, recency_in_days)
		@section_name = section_name
		@search_term = search_term
		@article_sub_urls = []
		@search_matches = []
		@recency_in_days = recency_in_days
		@@searches << self
	end

	def self.searches
		@@searches
	end

	def self.get_sections
		NyTimes::Scraper.scrape_menu
		@@sections
	end

	def self.add_section(section_name, section_url)
		new_section = Hash[section_name, section_url]
		@@sections.merge!(new_section)
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