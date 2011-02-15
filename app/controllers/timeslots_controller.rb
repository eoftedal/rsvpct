class TimeslotsController < ApplicationController

  def index
	@group = current_group
    @timeslots = @group.timeslots
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeslots }
    end
  end


  def show
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeslot }
    end
  end


  def new
    @timeslot = Timeslot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeslot }
    end
  end


  def edit
    @timeslot = Timeslot.find(params[:id])
  end


  def create
    @timeslot = Timeslot.new(params[:timeslot])
	@timeslot.group = current_group
    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to([current_group, @timeslot], :notice => 'Timeslot was successfully created.') }
        format.xml  { render :xml => @timeslot, :status => :created, :location => @timeslot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      if @timeslot.update_attributes(params[:timeslot])
        format.html { redirect_to([current_group, @timeslot], :notice => 'Timeslot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    respond_to do |format|
      format.html { redirect_to(timeslots_url) }
      format.xml  { head :ok }
    end
  end
end
