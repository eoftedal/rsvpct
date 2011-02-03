module TimeslotsHelper
	require 'digest/md5'
	def coming(timeslot = @timeslot)
		timeslot.answers.select { |a| a.joining }
	end
	def coming_count(timeslot = @timeslot) 
		coming(timeslot).map{|a| a.extra + 1 }.reduce(0) { |sum, value | sum + value } 
	end

	def not_coming
		@timeslot.answers.select { |a| !a.joining }
	end
	def no_answer
		players = Player.find(:all)
		players.select { |p| @timeslot.answers.detect { |a| a.player == p } == NIL }
	end
	def md5 (text) 
		Digest::MD5.hexdigest(text)
	end
end
