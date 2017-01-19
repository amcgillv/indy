module AdminHelper

    def breadcrumbs
        root = "<h1>#{link_to "Home", root_path} / #{link_to "Admin", admin_path}"
        caboose = "</h1>"
        path = ""
        if params[:controller] != "admin"
            slug = params[:controller][6..-1]
            if slug == "thelists"
                slug = "The List"
            end
            path = " / #{link_to slug.capitalize, :controller => params[:controller]}"
            if params[:action] != "index"
                if slug == "archive" || slug == "article"
                    path = path + " / Edit"
                else
                    path = path + " / " + params[:action].capitalize
                end
            end
        elsif params[:action] == 'emails'
            path = " / Emails"
        end
        # raw( / #{link_to "Issues", admin_issues_path} / Issue </h1>")
        raw(root + path + caboose)
    end

end
