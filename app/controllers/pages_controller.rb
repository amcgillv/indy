class PagesController < ApplicationController

    # caches_action :map, :about, :advertise, :apply
    # caches_action :show, :cache_path => Proc.new { |c| c.params }
    # caches_action :search, :cache_path => Proc.new { |c| c.params }, :unless => Proc.new { |c| c.send(:current_user).try(:admin?) }
    # caches_action :author, :cache_path => Proc.new { |c| c.params }, :unless => Proc.new { |c| c.send(:current_user).try(:admin?) }
    # http://cobaltedge.com/rails-action-caching-with-query-parameters

    def error_404
        @title = '404'
    end

    def error_500
        @title = '500'
    end

    def most_recent_issue
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
        redirect_to "/i/#{@issue.id}", :status => 302
    end

    def email
        if !params[:email].blank? && Email.find_by_email(params[:email]).nil?
            begin 
                Email.create!(email: params[:email]) # list subscription in model
            rescue RecordInvalid => e 
                redirect_to "/not_found"
            else
                p = {}
                p[:email] = params[:email] if !params[:email].empty?
                p[:first_name] = params[:first_name] if !params[:first_name].empty?
                p[:last_name] = params[:last_name] if !params[:last_name].empty?
                # puts "//////////////////////////////////////////////////////////////"
                chimp_subscribe p
            end
        end
    end

    def all_issues
        @title = "Archive"
        @issues = Issue.order("date DESC")
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
    end

    def search
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
        if !params[:search].blank? && params[:search].length > 1
            search = params[:search]
            @article_articles = Article.where(:published => true).where('lower(body) LIKE lower(?) OR lower(title) LIKE lower(?) OR lower(by) LIKE lower(?) OR lower(illustrator) LIKE lower(?)', "%#{search}%", "%#{search}%", "%#{search}%").order("published_at DESC")
            @archive_articles = Archive.where(:status => 'publish').where('lower(content) LIKE lower(?) OR lower(title) LIKE lower(?) OR lower(author) LIKE lower(?)', "%#{search}%", "%#{search}%", "%#{search}%").order("wp_post_date DESC")
            @articles = @article_articles + @archive_articles
        end
    end

    def author
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
        if params[:n] == "all"
            @title = "Articles by " + params[:n]
            @article_articles = Article.where(:by => nil, :published => true)
            @archive_articles = Archive.where(:author => '', :status => 'publish')
            @articles = @article_articles + @archive_articles
        elsif !params[:n].blank?
            @title = "Articles by " + params[:n]
            author = params[:n]
            @article_articles = Article.where(:published => true).where('lower(by) LIKE lower(?)', "%#{author}%").order("published_at DESC")
            @archive_articles = Archive.where(:status => 'publish').where('lower(author) LIKE lower(?)', "%#{author}%").order("wp_post_date DESC")
            @articles = @article_articles + @archive_articles
        end
    end

    def illustrator
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
        if !params[:n].blank?
            @title = "Illustrations By " + params[:n]
            illustrator = params[:n]
            @article_articles = Article.where(:published => true).where('lower(illustrator) LIKE lower(?)', "%#{illustrator}%").order("published_at DESC")
            @archive_articles = Archive.where(:status => 'publish').where('lower(illustrator) LIKE lower(?)', "%#{illustrator}%").order("wp_post_date DESC")
            @articles = @article_articles + @archive_articles
        end
    end

    def about
        @title = "About"
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
    end

    def advertise
        @title = "Advertise"
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
    end

    def apply
        @title = "Apply"
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
    end

    def list
        @title = "The List"
        @thelist = Thelist.find(1)
        @issue = Issue.where("date IS NOT NULL").order("date DESC").first
    end

    private

        def chimp_subscribe(p)
            api_key = "64bf8ffdd78dc9ba591c7fc7b3c351d8-us1"
            list_id = "c9e1b322ef"
            dc = "us1"
            # member_id = Digest::MD5.hexdigest(p.email)

            uri = URI.parse("https://" + dc + ".api.mailchimp.com/3.0/lists/" + list_id + "/members/")# + member_id)
            req = Net::HTTP::Post.new(uri.path)
            req.body = {
                'apikey' => api_key,
                'email_address' => p[:email], 
                'status' => 'subscribed'
            }.to_json
            if !p[:first_name] or !p[:last_name]
                req['merge_fields'] = {}
                req['FNAME'] = p[:first_name] unless p[:first_name].nil?
                req['LNAME'] = p[:last_name] unless p[:last_name].nil? 
            end
            req.content_type = "application/json"
            # next line per: http://stackoverflow.com/questions/30360451/calling-mailchimp-api-v3-0-with-net?rq=1
            # fucking weird shit
            req["Authorization"] = "chaz " + api_key 

            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER # VERIFY_NONE for development

            res = http.request(req)

            return res
        end
end
