class Admin::ArchiveController < ApplicationController
    before_filter :verify_is_admin
    layout "admin"
    def index
        @articles = Archive.order("wp_post_date DESC").paginate(:per_page=> 30, :page => params[:page])
        if !params[:search].nil?
            @articles = @articles.where('lower(title) LIKE lower(?)', "%#{params[:search]}%")
        end
    end

    def show
        @article = Archive.find(params[:id])
    end

    def update
        @article = Archive.find(params[:id])
        expire_action(:controller => "/home", :action => "index")
        expire_action(:controller => "/pages", :action => "search")
        expire_action(:controller => "/pages", :action => "author")
        respond_to do |format|
          if @article.update_attributes(params[:archive])
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
      @article = Archive.find(params[:id])
      @article.destroy
      expire_action(:controller => "/home", :action => "index")
      expire_action(:controller => "/pages", :action => "search")
      expire_action(:controller => "/pages", :action => "author")
      respond_to do |format|
        format.html { redirect_to admin_archive_index_path }
        format.json { head :no_content }
      end
    end

    private
        def grab_first_image
            if html = Nokogiri::HTML(@article.formatted_content)
                if @article.first_image_url = html.search("//img/@src")[0].to_s
                    @article.save
                end
            end
        end

end