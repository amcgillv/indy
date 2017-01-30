module ArticleHelper
	def createtags(body)
		if !body.nil?
			zstart = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"inner-large-image\">\n<span class=\"zoom\">"
			zend = "</span>\n</div>\n</div>\n<div class=\"article-content\">\n<div class=\"article-content-inner\">"
			hstart = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"inner-hero-image\">"
			hend = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"article-content-inner\">"
			nstart = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"inner-normal-image\">"
			nend = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"article-content-inner\">"
			lstart = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"inner-large-image\">"
			lend = "</div>\n</div>\n<div class=\"article-content\">\n<div class=\"article-content-inner\">"
			body = sanitize(body, tags: %w(del dd h3 address big sub tt a ul h4 cite dfn h5 small kbd code b ins img h6 sup pre strong blockquote acronym dt br p samp iframe li ol var em h1 i abbr h2 span hr), attributes: %w(name href cite class title src xml:lang height datetime alt abbr width id class style))
            # changes to default atttibutes
            # removed tags: div
            # added tags: iframe
            # removed attributes:
            # added attributes: id class style

            body = body
            .gsub(%r{\[start zoom\]}, zstart)
            .gsub(%r{\[end zoom\]}, zend)
            .gsub(%r{\[start hero\]}, hstart)
            .gsub(%r{\[end hero\]}, hend)
            .gsub(%r{\[start normal\]}, nstart)
            .gsub(%r{\[end normal\]}, nend)
            .gsub(%r{\[start large\]}, lstart)
            .gsub(%r{\[end large\]}, lend)
            raw(body)
        end
    end
    def removetags(body)
    	if !body.nil?
    		body = body
    		.gsub(%r{\[start zoom\]}, "")
    		.gsub(%r{\[end zoom\]}, "")
    		.gsub(%r{\[start hero\]}, "")
    		.gsub(%r{\[end hero\]}, "")
    		.gsub(%r{\[start normal\]}, "")
    		.gsub(%r{\[end normal\]}, "")
    		.gsub(%r{\[start large\]}, "")
    		.gsub(%r{\[end large\]}, "")
    		raw(body)
    	end
    end

    def row_item_of_article_or_archive(a)
    	row_item = Hash.new
    	row_item[:has_image] = !a.first_image_url.blank?
    	row_item[:image_url] = a.first_image_url
    	row_item[:title] = a.title
    	row_item[:subtitle] = a.subtitle
    	row_item[:category] = a.category
    	if a.respond_to?(:wp_post_date) # we have a wordpress archive guy on our hands
    		row_item[:hotlink] = "/a/#{a.id}"
    		row_item[:author] = link_people(a.author, "/author")
    		row_item[:excerpt] = raw(a.content.nil? ? "" : removetags(strip_tags(a.formatted_content)).split[0..60].join(' ') + " &hellip;")
    		row_item[:edit_url] = "/admin/archive/" + a.id.to_s
    		row_item[:just_image] = !a.first_image_url.blank? && removetags(strip_tags(a.formatted_content)).gsub(/\s/, '').gsub(/&nbsp;/, '').blank?
    		row_item[:date] = a.wp_post_date.to_time.iso8601	
    		row_item[:timeago] = time_ago_in_words(a.wp_post_date)
    	else # normal article
    		row_item[:hotlink] = "/#{a.id}"
    		row_item[:author] = link_people(a.by, "/author")
    		row_item[:excerpt] = raw(a.body.nil? ? "" : removetags(strip_tags(a.body)).split(/\s+/)[0..60].join(' ') + " &hellip;")
    		row_item[:edit_url] = "/admin/article" + a.id.to_s
    		row_item[:just_image] = !a.first_image_url.blank? && removetags(strip_tags(a.body)).gsub(/\s/, '').gsub(/&nbsp;/, '').blank?
    		row_item[:date] = a.published_at.to_time.iso8601	
    		row_item[:timeago] = time_ago_in_words(a.published_at)
    	end
    	return row_item
    end

    def link_people(people, route)
        return "" if people.blank?
        authors = []
        #fucking Oxford comma is gonna ruin me
        people = people.gsub(", and", " and").gsub(", &", " &")
        # get rid of initial comma list, leave the last thing untouched
        if people.include? ", "
            comma_split = people.split ", "
            authors = authors + comma_split[0..-2]
            people = comma_split[-1]
        end
        # stuff left over should have the names on both side of the ampersand.
        # fucking Oxford comma:
        if people.include? " & "
            amp_split = people.split " & "
            authors = authors + amp_split[0..-2]
            people = amp_split[-1]
        end
        if people.include? " and "
            and_split = people.split " and "
            authors = authors + and_split[0..-2]
            people = and_split[-1]
        end
        # should be left with one author
        authors.push people
        # linkify
        authors = authors.map { |a| '<a href="' + route + '?n=' + a + '">' + a + '</a>' }
        # rails comes thru with the to_sentence
        people = authors.to_sentence({ last_word_connector: " & ", two_words_connector: " & "})
    	people = "by " + people
    	raw(people)
    end
end
