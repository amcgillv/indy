class Admin::ThelistsController < ApplicationController
    before_filter :verify_is_admin
    layout "admin"
    def index
        if Thelist.all.first.nil?
            @thelist = Thelist.new
        else
            @thelist = Thelist.find(1)
        end
    end

    def update
        @thelist = Thelist.find(1)
        respond_to do |format|
          if @thelist.update_attributes(params[:thelist])
            format.html { redirect_to :controller => "admin/thelists", :action => "index"}
          else
            format.html { render action: "index" }
          end
        end
    end

    def create
        @thelist = Thelist.new(params[:thelist])
        respond_to do |format|
          if @thelist.save
            format.html { redirect_to :controller => "admin/thelists", :action => "index"}
          else
            format.html { render action: "index" }
          end
        end
    end
end
