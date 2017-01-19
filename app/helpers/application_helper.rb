module ApplicationHelper

    def cache_unless_admin *args
      if !current_user.present?
        cache args do
          yield
        end
      else
        yield
      end
    end
end
