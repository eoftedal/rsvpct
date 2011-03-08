class Timeslot < ActiveRecord::Base
	has_many :answers
	belongs_to :group
	
	require 'digest/md5'
	
	
	def coming
		answers.select { |a| a.joining }
	end
	def coming_count 
		coming().map{|a| a.extra + 1 }.reduce(0) { |sum, value | sum + value } 
	end

	def not_coming
		answers.select { |a| !a.joining }
	end
	def no_answer
		players = Player.find(:all)
		players.select { |p| answers.detect { |a| a.player == p } == NIL }
	end
	def md5 (text) 
		Digest::MD5.hexdigest(text)
	end
end
