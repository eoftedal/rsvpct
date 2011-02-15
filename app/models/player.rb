class Player < ActiveRecord::Base
	validates_presence_of :email#, :oauth_token, :oauth_secret
	validates_uniqueness_of :email
	has_many :memberships, :dependent => true
	has_many :groups, :through => :memberships
end
