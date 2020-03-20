class NyTimes::SearchMatch
	attr_accessor :context, :article_title, :article_url, :search_id

	def initialize(paragraph, article_title, article_url)
		@search_id = NyTimes::Search.searches.last.search_matches.count + 1
		@context = paragraph
		@article_title = article_title
		@article_url = article_url
		NyTimes::Search.searches.last.search_matches << self
	end
end