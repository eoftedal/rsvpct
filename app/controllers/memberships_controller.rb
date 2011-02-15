class MembershipsController < ApplicationController
	def index
		#current_group.memberships.each{ |d| d.delete }
		@members = current_group.members
		@owner = current_group.owner
	end
	
	def new
		@membership = Membership.new
	end
	
	def create
		@membership = Membership.new(params[:membership])
		@membership.player = Player.find(params[:player_id])
		@membership.group = current_group
		respond_to do |format|
		  if @membership.save
			format.html { redirect_to(group_memberships_url(current_group), :notice => 'membership was successfully created.') }
			format.xml  { render :xml => @membership, :status => :created, :location => @membership }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
		  end
		end
	end
end
