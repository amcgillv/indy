class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :styles => { :content => "2000>", :thumb => "300>" },
                    :convert_options => {
                        :content => "-quality 80 -strip",
                        :thumb => "-quality 80 -strip"
                    },
                    :storage => :s3,
                    :s3_credentials => Rails.root.join("config/s3.yml"),
                    :path => "/ckeditor/:style/:id/:filename"

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
