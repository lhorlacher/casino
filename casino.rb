require_relative 'player'

class Casino
	attr_accessor :player

	def initialize
		puts "Welcome to the Casino!"
		# for now 1 player
		# we should be able to add as many players
		# we should be able to switch among players
		@player = Player.new
	end
end

Casino.new