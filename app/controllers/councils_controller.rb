class CouncilsController < ApplicationController
  before_filter :admin_required  
  before_filter :current_council  

  # GET /councils
  # GET /councils.json
  def index
    
    if @current_user.id == 1
      @councils = Council.find(:all, :order => 'councilnumber')
    else  
      @councils = Council.find(:all, :conditions => ['id = ?', @current_user.council_id], :order => 'councilnumber')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @councils }
    end
  end

  # GET /councils/1
  # GET /councils/1.json
  def show
    @council = Council.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @council }
    end
  end

  # GET /councils/new
  # GET /councils/new.json
  def new
    if @current_user.id == 1
      @council = Council.new
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @council }
    end
  end

  # GET /councils/1/edit
  def edit
    @council = Council.find(params[:id])
  end

  # POST /councils
  # POST /councils.json
  def create
    
    if @current_user.id == 1
      @council = Council.new(params[:council])
    end

    respond_to do |format|
      if @council.save
        format.html { redirect_to @council, :notice => 'Council was successfully created.' }
        format.json { render :json => @council, :status => :created, :location => @council }
      else
        format.html { render :action => "new" }
        format.json { render :json => @council.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /councils/1
  # PUT /councils/1.json
  def update
    @council = Council.find(params[:id])

    respond_to do |format|
      if @council.update_attributes(params[:council])
        format.html { redirect_to @council, :notice => 'Council was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @council.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /councils/1
  # DELETE /councils/1.json
  def destroy
    
    if @current_user.id == 1
      @council = Council.find(params[:id])
      @council.destroy
    end
    
    respond_to do |format|
      format.html { redirect_to councils_url }
      format.json { head :ok }
    end
  end
end
