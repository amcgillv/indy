require 'open-uri'

class Issue < ActiveRecord::Base
    attr_accessible :date, :document_number, :published, :title, :url_slug, :scribd, :image_url, :cover

    has_attached_file :cover
    has_many :articles

    before_validation :issuu_scrape
    validates_attachment_presence :cover
    validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    validate :scraped_issue_must_have_document_number


    def issuu_scrape
        if !url_slug.nil? && !scribd
            if data = Nokogiri::HTML(open("https://issuu.com/theindy/docs/" + url_slug))
                url = data.xpath("//meta[@property='og:image']/@content").first.value
                number = url.scan( /[0-9]*-[a-z0-9]*/).last
                self.document_number = number
                self.cover = URI.parse("http://image.issuu.com/" + number + "/jpg/page_1.jpg")
            end
            if !title.nil?
                scraped_title = data.xpath("//meta[@property='og:title']/@content").first.value
                self.title = scraped_title
            end
        end
    end

    def scraped_issue_must_have_document_number
        if !scribd && document_number.blank?
             # shortnames can contain _- letters and numbers 
            errors.add(:document_number, "didn't scrape correctly. Shit. Call Max at 203-313-3609 and tell him he needs to fix it. ")
        end
    end

    def before_image_post_process
        false
    end

end
