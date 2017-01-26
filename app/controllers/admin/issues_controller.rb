class Admin::IssuesController < ApplicationController
  before_filter :verify_is_admin
  layout 'admin'
  require 'open-uri'
  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.order("date DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])
    logger.debug @issue.inspect
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new

    @new = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(params[:issue])

    respond_to do |format|
      if @issue.save
        # expire_action(:controller => "/issue", :action => "toc")
        format.html { redirect_to [:admin, @issue], notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
        if @issue.update_attributes(params[:issue])
            # expire_action(:controller => "/issue", :action => "toc")
            format.html { redirect_to [:admin, @issue], notice: 'Issue was successfully updated.' }
        else
            format.html { render action: "edit" }
        end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    # expire_action(:controller => "/issue", :action => "toc")
    respond_to do |format|
      format.html { redirect_to admin_issues_url }
      format.json { head :no_content }
    end
  end

end

# id_array = ["75138238","74399561","73085188","72388452","71578763","71092945","69917330","66949696","65967856","65129860","53575352","53090371","52655021","52654739","51552805","51064065","50468007","50467902","50136995","49064346","48654676","44555108","44554305","44553876","44553518","40031389","40031339","38496744","38496664","38496304","38495950","30000628","29672277","28908173","28714281","28638686","28638502","28638141","28637687"]

# id_array.each do |id|
#   Issue.destroy_all(:document_number => id)
#   @issue = Issue.new
#   data = Nokogiri::HTML(open("http://www.scribd.com/doc/" + id + "/"))
#   @issue.title = data.css('title')[0].content
#   @issue.document_number = id
#   @issue.image_url = data.css('meta[property="og:image"]')[0]['content']
#   @issue.scribd = true
#   @issue.save
# end
