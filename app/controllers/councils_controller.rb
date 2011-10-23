class CouncilsController < ApplicationController
  # GET /councils
  # GET /councils.json
  def index
    @councils = Council.all

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
    @council = Council.new

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
    @council = Council.new(params[:council])

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
    @council = Council.find(params[:id])
    @council.destroy

    respond_to do |format|
      format.html { redirect_to councils_url }
      format.json { head :ok }
    end
  end
end
