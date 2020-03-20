class NyTimes::Scraper
	def self.scrape_menu
		html = open("https://www.nytimes.com/")
		doc = Nokogiri::HTML(html)

		#I want to grab the section of the nytimes
		doc.css(".css-1vxc2sl li").each do |li|
			if li.css("a").attribute("href") && li.css("a").attribute("href").value != "/"
				section_name = li.css("a").text
				section_url = li.css("a").attribute("href").value
				# binding.pry
				NyTimes::Search.add_section(section_name, section_url)
			end


			# if !NyTimes::Search.sections.include?(section_name) && section_name != ""
			# 	NyTimes::Search.add_section(section_name, section_url)
			# end
		end
	end

	def self.scrape_section(section_name, section_url)
		html = open(section_url)
		doc = Nokogiri::HTML(html)
	end
end