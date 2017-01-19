class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :wats_good

  def wats_good
    response.headers['X-Charlie-Was-Here'] = "@}-;-'---@>-->--    (^_-)<(a rose for you)"
  end

    def after_sign_in_path_for(user)
        params[:next] || super
    end

    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: lambda { |exception| render_error 500, exception }
      rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
    end

    private

        def render_error(status, exception)
          respond_to do |format|
            format.html { render template: "pages/error_#{status}", layout: 'layouts/application', status: status }
            format.all { render nothing: true, status: status }
          end
        end


        def verify_is_admin
            (current_user.nil?) ? redirect_to(login_path(:next => request.path)) : (redirect_to(login_path(:next => request.path)) unless current_user.admin?)
        end

        

end
