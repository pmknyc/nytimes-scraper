# require_relative "../scraper.rb"

class NyTimes::CLI
	@@instances = []
	
	def initialize
		@@instances << self
	end

	def self.instances
		@@instances
	end

	def greeting
		puts "Welcome to the New York Times Scraper"
		NyTimes::Search.get_sections
		display_sections
	end

	def display_sections
		puts "\n Please choose from one of these sections"

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

		while !NyTimes::Search.sections.include?(section_input) && section_input != "all"#one of the sections in the NyTimes, so in the Search.sections
			puts "Please enter a valid section name"
			section_input = gets.strip
		end

		puts "Please enter a search term"
		search_input = gets.strip
		# Use the inputs in some Search instance method
		
		if section_input == "all"
			NyTimes::Search.sections.each do |section_name, section_url|
				puts "searching the #{section_name} section..."
				search = NyTimes::Search.new(section_name, search_input)
				search.section_url = NyTimes::Search.sections[section_name]
				search.search_section
				# binding.pry
				# show_search_match
				show_search_summary(search)
			end
		else
			search = NyTimes::Search.new(section_input, search_input)
			search.section_url = NyTimes::Search.sections[section_input]
			search.search_section
			show_search_summary(search)
		end

		puts "Would you like to do another search? (y/n)"
		input = gets.strip

		while input != "y" && input != "n"
			puts "Please enter y or n"
			input = gets.strip
		end

		if input == "y"
			display_sections
		end
	end

	def show_search_match(search_match)
		puts search_match.search_match_id
		puts search_match.context
		puts "#{"ARTICLE TITLE:".red} #{search_match.article_title.gsub(" - The New York Times", "")}"
		puts "#{"ARTICLE AUTHOR(S):".red} #{search_match.article_author.join(", ")}"
		puts "#{"ARTICLE DATE:".red} #{search_match.article_date.split("T").first}"
		puts "#{"ARTICLE LINK:".red} #{search_match.article_url}"
		puts
	end

	def show_search_matches
		search.search_matches.each do |search_match|
			puts search_match.search_match_id
			puts search_match.context
			puts "#{"ARTICLE TITLE:".red} #{search_match.article_title.gsub(" - The New York Times", "")}"
			puts "#{"ARTICLE AUTHOR:".red} #{search_match.article_author}"
			puts "#{"ARTICLE DATE:".red} #{search_match.article_date.split("T").first}"
			puts "#{"ARTICLE LINK:".red} #{search_match.article_url}"
			puts
			# binding.pry
		end
	end

	def show_search_summary(search)
		puts "#{search.section_name} section search overview:"
		puts "Total Articles scanned: #{search.article_sub_urls.count}"
		puts "Total Hits: #{search.search_matches.count}"
	# binding.pry
		puts "Total matching articles: #{search.search_matches.collect {|match| match.article_title}.uniq.count}"
		puts puts		
	end
end