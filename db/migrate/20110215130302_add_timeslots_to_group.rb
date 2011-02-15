class AddTimeslotsToGroup < ActiveRecord::Migration
  def self.up
	change_table :timeslot do |t|
		t.references :group, :default => 1
	 end
  end

  def self.down
  end
end
