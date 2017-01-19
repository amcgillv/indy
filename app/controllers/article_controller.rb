class ArticleController < ApplicationController

	def show
        @article = Article.find(params[:id])
        @og_title, @title = @article.title
        @og_image = @article.first_image_url if !@article.first_image_url.blank?
        @og_type = "article"
    end

    def show_a
        @article = Archive.find(params[:id])
        @og_title, @title = @article.title
        @og_image = @article.first_image_url if !@article.first_image_url.blank?
        @og_type = "article"
    end

end
