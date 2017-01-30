class Article < ActiveRecord::Base
    attr_accessible :body, :by, :category, :promo, :published_at,
        :tags, :title, :subtitle, :hero, :hero_caption, :hero_x,
        :hero_y, :first_image_url, :excerpt, :pullquote,
        :published, :has_hero, :column_width, :illustrator,
        :issue_id, :featured

    has_attached_file :hero,
        :styles => {:small => "200x200>", :medium => "500x500>", :large => "700x700>", :xlarge => "1000x1000>" },
        :convert_options => {
            :small => "-quality 80 -strip",
            :medium => "-quality 80 -strip",
            :large => "-quality 80 -strip",
            :xlarge => "-quality 80 -strip"
        },
        :storage => :s3,
        :s3_credentials => Rails.root.join("config/s3.yml"),
        :path => "/articles/:style/:id/:filename"

    belongs_to :issue, :foreign_key => :issue_id

    validates_attachment_content_type :hero, :content_type => /\Aimage/
end
