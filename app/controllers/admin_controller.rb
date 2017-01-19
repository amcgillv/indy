class AdminController < ApplicationController
    before_filter :verify_is_admin

    def index
    end

    def emails
      @emails = Email.all
    end

end
