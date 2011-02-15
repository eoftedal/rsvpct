module MembershipsHelper

	def available_players
		 @players = Player.all
		 @players.delete current_group.owner
		 current_group.players.each{ |p| @players.delete p }
		 @players
	end
end
