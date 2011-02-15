class Timeslot < ActiveRecord::Base
	has_many :answers
	belongs_to :group
end
