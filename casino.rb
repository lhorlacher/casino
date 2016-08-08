require_relative 'player'

class Casino
	#attr_accessor

	def initialize
		puts "Welcome to the Casino!"
		@player = Player.new
	end
end

Casino.new