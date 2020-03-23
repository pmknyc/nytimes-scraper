class NyTimes::Scraper
	def self.scrape_menu
		html = open("https://www.nytimes.com/")
		doc = Nokogiri::HTML(html)

		#I want to grab the section of the nytimes
		doc.css(".css-1vxc2sl li").each do |li|
			if li.css("a").attribute("href") && li.css("a").attribute("href").value != "/" && li.css("a").text != "Video"
				section_name = li.css("a").text
				section_url = li.css("a").attribute("href").value
				# binding.pry
				NyTimes::Search.add_section(section_name, section_url)
			end
		end
	end

	def self.scrape_section(section_name, section_url)
    search = NyTimes::Search.searches.last
    # binding.pry
		html = open(section_url)
		section_doc = Nokogiri::HTML(html)
    # binding.pry
    section_doc.css("section a").each do |a|
      # binding.pry
      # puts a.attribute("href").value
      # if a.attribute("href") == nil
      #     puts "nil link value"
      if  a.attribute("href") != nil &&
          a.attribute("href").value.include?("html") &&
          (a.attribute("href").value.include?(Time.now.to_s.split(" ").first.gsub("-", "/")) || a.attribute("href").value.include?((Time.now - 86400).to_s.split(" ").first.gsub("-", "/"))) &&
          !a.attribute("href").value.include?("/membercenter") &&
          !a.attribute("href").value.include?("/content") &&
          !a.attribute("href").value.include?("/interactive") #&&
          # !a.attribute("href").value.include?("https") #&&
          # a.attribute("href").value.include?("/#{section_name}/") 

          if !search.article_sub_urls.include?(a.attribute("href").value)
          	search.article_sub_urls << a.attribute("href").value
        	end

          # NyTimes::Search.searches.last.total_articles += 1
          # puts a.attribute("href").value
      end
    # binding.pry
    end

    # binding.pry

    search.article_sub_urls.each do |link|
    if !link.include?("https")
      link = "https://www.nytimes.com/#{link}"
    end

    html = open(link)
    article_doc = Nokogiri::HTML(html)
  
    article_doc.css(".css-exrw3m.evys1bk0").collect do |par|
        if par.text.include?(" #{search.search_term} ")
            # search.total_hits += par.text.scan(" #{search.search_term} ").count
            new_par = par.text.gsub(" #{search.search_term} ", " #{search.search_term} ".green)
            new_par = new_par.gsub("â\u0080\u009C", "\"").gsub("â\u0080\u009D", "\"").gsub("â\u0080\u0099", "'").gsub("â\u0080\u0094", "—")

            title = article_doc.css("title").text.gsub("â\u0080\u009C", "\"").gsub("â\u0080\u009D", "\"").gsub("â\u0080\u0099", "'").gsub("â\u0080\u0094", "—")
            author = article_doc.css(".css-1fv7b6t.e1jsehar1 span").collect { |span| span.text}
            date = article_doc.css(".css-1xtbm1r.epjyd6m3").css("time @datetime").to_s#(".css-ld3wwf.e16638kd1").css(".css-1sbuyqj.e16638kd4").text

            NyTimes::SearchMatch.new(new_par, title, link, author, date)

            # puts %$#{new_par}$
            # puts "#{"ARTICLE TITLE:".red} #{article_doc.css("title").text.gsub("â\u0080\u009C", "\"").gsub("â\u0080\u009D", "\"").gsub("â\u0080\u0099", "'").gsub("â\u0080\u0094", "—")}"
            # puts "#{"ARTICLE LINK:".red} #{link}" 
            # puts
            # matching_pars << new_par
        end
    end
end 
    # binding.pry
	end
end