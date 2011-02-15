class Group < ActiveRecord::Base
	has_many :timeslots
	has_many :memberships, :dependent => true
	has_many :players, :through => :memberships
	
end
