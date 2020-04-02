require "open-uri"
require "nokogiri"
require "pry"
require "colorize"
require 'require_relative'

module NyTimesSearch
  class Error < StandardError; end
  # Your code goes here...
end
require_relative "./ny_times_search/version"
require_relative "./ny_times_search/cli" 
require_relative "./ny_times_search/search"
require_relative "./ny_times_search/scraper" 
require_relative "./ny_times_search/search_match"
require "date"

