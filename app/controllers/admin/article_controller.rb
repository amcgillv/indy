class Admin::ArticleController < ApplicationController
    before_filter :verify_is_admin
    layout 'admin'

    def index
        @articles = Article.order("created_at DESC").paginate(:per_page=> 30, :page => params[:page])
    end

    def new
        @article = Article.new
        @article.save

        redirect_to "/admin/article/#{@article.id}"

        # expire_action(:controller => "/pages", :action => "map")
        # expire_action(:controller => "/homepage", :action => "index")
        # expire_action(:controller => "/pages", :action => "show")
        # expire_action(:controller => "/pages", :action => "search")
        # expire_action(:controller => "/pages", :action => "author")

    end

    def show
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        params[:article][:body] = params[:article][:body].gsub(/([a-z])- /, '\1')
        respond_to do |format|
          if @article.update_attributes(params[:article])
            expire_action(:controller => "/home", :action => "index")
            expire_action(:controller => "/pages", :action => "search")
            expire_action(:controller => "/pages", :action => "author")
            grab_first_image
            format.html { redirect_to [:admin, @article], notice: 'Article was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "show" }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      expire_action(:controller => "/home", :action => "index")
      expire_action(:controller => "/pages", :action => "search")
      expire_action(:controller => "/pages", :action => "author")
      respond_to do |format|
        format.html { redirect_to admin_article_index_path }
        format.json { head :no_content }
      end
    end

    private
        def grab_first_image
            if html = Nokogiri::HTML(@article.body)
                if @article.first_image_url = html.search("//img/@src")[0].to_s
                    @article.save
                end
            end
        end

end