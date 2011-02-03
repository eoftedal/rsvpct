class AddOAuthFieldsOnUser < ActiveRecord::Migration
  def self.up
	add_column :players, :oauth_token, :string
	add_column :players, :oauth_secret,:string 
  end

  def self.down
	remove_column :players, :oauth_token
	remove_column :players, :oauth_secret
  end
end
