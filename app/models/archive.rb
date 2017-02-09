class Archive < ActiveRecord::Base
    attr_accessible :author, :category, :content,
        :creator, :excerpt, :link, :post_type,
        :status, :title, :wp_post_date, :wp_post_id,
        :subtitle, :tags, :formatted_content,
        :first_image_url, :excerpt, :pullquote,
        :column_width, :illustrator

    alias_attribute :published_at, :wp_post_date
    alias_attribute :by, :author
    alias_attribute :body, :formatted_content
end
