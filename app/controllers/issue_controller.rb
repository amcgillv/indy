class IssueController < ApplicationController

    def toc
		@issue = Issue.find(params[:id])
        @title = @issue.title
        @nav_issue = @issue
        # so we can print articles by category in toc
        @articles = @issue.articles.sort do |a, b| 
        	cat = a.category <=> b.category
        	cat == 0 ? a.title <=> b.title : cat # tiebreak with title
        end
        @og_title, @title = @issue.title
        @og_image = "http://image.issuu.com/" + @issue.document_number + "/jpg/page_1.jpg" if !@issue.document_number.nil?
        @og_type = "book"
    end

    def show
        @issue = Issue.find(params[:id])
        @nav_issue = @issue
        @title = @issue.title
        @og_title, @title = @issue.title
        @og_image = "http://image.issuu.com/" + @issue.document_number + "/jpg/page_1.jpg" if !@issue.document_number.nil?
        @og_type = "book"
    end

end
