class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
	  t.references :player
	  t.references :group
      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
