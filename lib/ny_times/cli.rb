# require_relative "../scraper.rb"

class NyTimes::CLI
	def greeting
		puts "Welcome to the New York Times Scraper"
		puts "Here are all the sections today's online paper:"

		NyTimes::Search.get_sections
		NyTimes::Search.section_names.each do |name|
			print "   #{name}   "
		end
		puts puts

		section_selection
	end

	def section_selection
		section_input = nil
		while section_input == nil 
			puts "What section would you like to search?"
			section_input = gets.strip
			# Use the inputs in some Search instance method
		end

		while !NyTimes::Search.sections.include?(section_input) #one of the sections in the NyTimes, so in the Search.sections
			puts "Please enter a valid section name"
			section_input = gets.strip
		end

		puts "Please enter a search term"
		search_input = gets.strip
		# Use the inputs in some Search instance method
		search = NyTimes::Search.new(section_input, search_input)
		search.section_url = NyTimes::Search.sections[section_input]
		search.search_section
		search.search_matches.each do |search_match|
			puts search_match.search_id
			puts search_match.context
			puts "#{"ARTICLE TITLE:".red} #{search_match.article_title.gsub(" - The New York Times", "")}"
			puts "#{"ARTICLE LINK:".red} #{search_match.article_url}"
			puts
			# binding.pry
		end

		puts 
		puts "Search Overview:"
		puts "Total Articles scanned: #{search.article_sub_urls.count}"
		puts "Total Hits: #{search.search_matches.count}"
	# binding.pry
		puts "Total matching articles: #{search.search_matches.collect {|match| match.article_title}.uniq.count}"
	end

	def search_results
		NyTimes::

		puts "Searched #{search.search_overview} articles"
	end
end