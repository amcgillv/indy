class Thelist < ActiveRecord::Base
    attr_accessible :image, :title
    has_attached_file :image,
        :styles => {:normal => "1000x2000>" },
        :convert_options => {
            :normal => "-quality 80 -strip"
        },
        :storage => :s3,
        :s3_credentials => Rails.root.join("config/s3.yml"),
        :path => "/articles/:style/:id/:filename"
    validates_attachment_content_type :image, :content_type => /\Aimage/
    has_attached_file :title,
        :styles => {:normal => "400x400>"},
        :convert_options => {
            :normal => "-quality 80 -strip",
        },
        :storage => :s3,
        :s3_credentials => Rails.root.join("config/s3.yml"),
        :path => "/articles/:style/:id/:filename"
    validates_attachment_content_type :title, :content_type => /\Aimage/

end
