class NyTimesSearch::SearchMatch
	attr_accessor :context, :article_title, :article_url, :search_match_id, :article_author, :article_date

	def initialize(paragraph, article_title, article_url, article_author, article_date)
		@search_match_id = NyTimesSearch::Search.searches.last.search_matches.count + 1
		@context = paragraph
		@article_title = article_title
		@article_url = article_url
		@article_author = article_author
		@article_date = article_date
		NyTimesSearch::Search.searches.last.search_matches << self
		NyTimesSearch::CLI.instances.last.show_search_match(self)
	end
end