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
		section_doc = Nokogiri::HTML(html)

    article_sub_urls = []
    # binding.pry
    section_doc.css("#site-content a").each do |a|
      # puts a.attribute("href").value
      if a.attribute("href") == nil
          puts "nil link value"
      elsif a.attribute("href").value.include?("html") &&
          a.attribute("href").value.include?(Time.now.to_s.split(" ").first.gsub("-", "/"))
          !a.attribute("href").value.include?("membercenter") &&
          !a.attribute("href").value.include?("content") &&
          !a.attribute("href").value.include?("interactive") &&
          !a.attribute("href").value.include?("https") #&&
          # a.attribute("href").value.include?("/#{section_name}/") 
          article_sub_urls << a.attribute("href").value
          NyTimes::Search.searches.last.total_articles += 1
          # puts a.attribute("href").value
          # binding.pry
      end
    end
    # binding.pry
	end
end