class HomeController < ApplicationController

	# homepage with issues
	# show issues, list, homepage nav
	def index
		@nav_issue = nil # being explicit
		# listhe
        @thelist = Thelist.find(1)
		# load page of issues. 20 per page
        @issues = Issue.where(:published => true).where("date IS NOT NULL").order("date DESC")
        # paginate
        issues_per_page = 20.0
        @pages = (@issues.length.to_f / issues_per_page).ceil

        page_num = 0
        start_index = 0

        if !params[:page].nil?
        	page_num = params[:page].to_i - 1
        	start_index = 1 + page_num * issues_per_page
        end

        end_index = issues_per_page + page_num * issues_per_page
        @issues = @issues[start_index..end_index]

        @og_title = "The College Hill Independent"
        @og_image = "http://www.theindy.org/assets/logo-500-9d75bd63dd39747aea346466eb7ed1ef.png"
        @og_type = "book"
	end

	# or, list view. used to view a specific section, or the whole archive.
	# show articles and homepage nav, as well as section title if it exists
	def feed
		@nav_issue = nil
		if params[:s].nil? # grab all articles
			@article_articles = Article.where(:published => true).order("published_at DESC")
        	@archive_articles = Archive.where(:status => 'publish').order("wp_post_date DESC")
        else # grab section's articles
            @article_articles = Article.where(:published => true).order("published_at DESC")
            						   .where('lower(category) LIKE lower(?)', "%#{params[:s]}%")
            @archive_articles = Archive.where(:status => 'publish').order("wp_post_date DESC")
            						   .where('lower(category) LIKE lower(?)', "%#{params[:s]}%")
        end
        @articles = @article_articles + @archive_articles # archives are older, come second.
        # paginate
        page = 0
        page = params[:page].to_i - 1 if !params[:page].nil?
        number = 40.0
        @pages = (@articles.length.to_f / number).ceil
        startnumber = 1 + page * number
        startnumber = 0 if params[:page].nil?
        endnumber = number + page * number
        @articles = @articles[startnumber..endnumber]

        # grab section title
        if params[:s].nil?
            @title = "Everything"
        else
            @title = @articles.first.category
        end
	end

end
