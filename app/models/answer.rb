class Answer < ActiveRecord::Base
  belongs_to :player
  belongs_to :timeslot
end
