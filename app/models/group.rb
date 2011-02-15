class Group < ActiveRecord::Base
	has_many :timeslots
	has_many :memberships
	has_many :players, :through => :memberships
	
end
