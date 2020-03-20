# require_relative "../scraper.rb"

class NyTimes::CLI
	def greeting
		puts "Welcome to the New York Times Scraper"
		puts "Here are all the sections today's online paper:"

		NyTimes::Search.get_sections
		puts NyTimes::Search.section_names

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
		# binding.pry
		puts "Searched #{search.search_overview} articles"
		# binding.pry
	end
end