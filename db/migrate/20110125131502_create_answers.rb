class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.boolean :joining
      t.integer :extra
      t.references :player
      t.references :timeslot

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
