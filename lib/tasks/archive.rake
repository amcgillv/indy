namespace :archive do
    task :import, [:url] => :environment do |t, args|
        if defined?(Rails) && (Rails.env == 'development')
             Rails.logger = Logger.new(STDOUT)
        end
        args.with_defaults(:url => "indybackup.xml")
        doc = Nokogiri::XML(open(args.url))
        items = doc.search(".//item")
        items.reverse_each do |event|
            if Archive.where("link = ?", event.at('link').text).exists?
                puts "this item has already been added"
            else
                author = ""
                event.xpath('wp:postmeta').each do |meta|
                    if meta.xpath('wp:meta_key').children.text.to_s == "Author"
                        author = meta.xpath('wp:meta_value').children.text.to_s
                        puts "author is " + author
                    end
                end

                category = event.at('category').text if !event.at('category').nil?

                first_image_url = nil
                if html = Nokogiri::HTML(event.search(".//content:encoded")[0].content.to_s)
                    first_image_url = html.search("//img/@src")[0].to_s
                end

                Archive.create!(
                    :author => author,
                    :category => category,
                    :content => event.search(".//content:encoded")[0].content.to_s,
                    :creator => event.search(".//dc:creator")[0].content.to_s,
                    :excerpt => event.search(".//excerpt:encoded")[0].content.to_s,
                    :link => event.at('link').text,
                    :post_type => event.search(".//wp:post_type")[0].content.to_s,
                    :status => event.search(".//wp:status")[0].content.to_s,
                    :title => event.at('title').text,
                    :wp_post_date => event.search(".//wp:post_date")[0].content.to_time,
                    :wp_post_id => event.search(".//wp:post_id")[0].content.to_i,
                    :formatted_content => "<p>" + event.search(".//content:encoded")[0].content.to_s.gsub("\n\n", "</p><p>").gsub("\n", "<br />") + "</p>",
                    :first_image_url => first_image_url
                )
            end
        end
    end
    task :illustrator, [:url] => :environment do |t, args|
        if defined?(Rails) && (Rails.env == 'development')
             Rails.logger = Logger.new(STDOUT)
        end
        args.with_defaults(:url => "indybackup.xml")
        doc = Nokogiri::XML(open(args.url))
        items = doc.search(".//item")
        a = 0
        items.reverse_each do |event|
            event.xpath('wp:postmeta').each do |meta|
                if meta.xpath('wp:meta_key').children.text.to_s == "Illustrator"
                    illustrator = meta.xpath('wp:meta_value').children.text.to_s
                    archive = Archive.find_by_wp_post_id(event.search(".//wp:post_id")[0].content.to_i)
                    a = a + 1
                    puts a.to_s + ":" + archive.title + " - " + illustrator
                    archive.illustrator = illustrator
                    archive.save
                end
            end
        end
    end
    # Article.where("id > 19 AND id < 32").each do |article|
    #     Archive.create!(
    #         :author => article.by,
    #         :category => article.category,
    #         :excerpt => article.excerpt,
    #         :status => 'publish',
    #         :title => article.title,
    #         :wp_post_date => article.published_at,
    #         :formatted_content => article.body,
    #         :first_image_url => article.first_image_url,
    #         :illustrator => article.illustrator,
    #         :pullquote => article.pullquote)
    #     article.destroy
    # end
    # Article.where("id > 32 AND id < 51").each do |article|
    #     Archive.create!(
    #         :author => article.by,
    #         :category => article.category,
    #         :excerpt => article.excerpt,
    #         :status => 'publish',
    #         :title => article.title,
    #         :wp_post_date => article.published_at,
    #         :formatted_content => article.body,
    #         :first_image_url => article.first_image_url,
    #         :illustrator => article.illustrator,
    #         :pullquote => article.pullquote)
    #     article.destroy
    # end
end

