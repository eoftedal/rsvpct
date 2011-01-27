class AnswersController < ApplicationController

  
  def show
	@timeslot = Timeslot.find(params[:timeslot_id])
  end

  def new
	current_user = Player.find(1) #TODO
	@timeslot = Timeslot.find(params[:timeslot_id])
	@answer = @timeslot.answers.detect{|a| a.player == current_user}
	
	if @answer == NIL
		
		@answer = Answer.new
		@answer.player = current_user
		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @answer }
		end
	else	
		redirect_to url_for(:action => "edit", :id => @answer.id)
	end

  end

  def edit
	current_user = Player.find(1) #TODO
	@timeslot = Timeslot.find(params[:timeslot_id])
	@answer = @timeslot.answers.detect{|a| a.player == current_user}
  end


  def create
    @answer = Answer.new(params[:answer])
	current_user = Player.find(1) #TODO
	@timeslot = Timeslot.find(params[:timeslot_id])
	@answer.timeslot = @timeslot
	@answer.player = current_user
    respond_to do |format|
      if @answer.save
		  format.html { render :action => "show" }
		  format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @timeslot = Timeslot.find(params[:timeslot_id])
	@answer = Answer.find(params[:id]);
    respond_to do |format|
      if @answer.update_attributes(params[:answer])		
		format.html { render :action => "show" }
		format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

end
