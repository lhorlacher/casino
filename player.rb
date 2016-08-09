# require 'pry'
# require 'colorize'

require_relative 'bankroll'

class Player
attr_accessor :name, :good_luck, :back_luck, :bankroll

	def initialize
		@name, @good_luck, @bad_luck = name_setup
		@bankroll = Bankroll.new
	end

	def name_setup
		puts "What would you like to be called?"
		puts "Name must be letters only and at least 4 characters."
		while true
			name = gets.strip
			if name !~ /^[a-zA-Z]{4,}$/
				puts "Use upper and lowercase letters only."
			else
				break
			end
		end
	luck(name)
	end

	def luck(name)
		puts "Now we need some general information about you.\n\n"
		puts "On a scale of 0 - ∞, how much do you like U2?"
		u2 = gets.strip.to_i
		puts "What is your favorite number?"
		digit = gets.strip.to_i
		puts "How old is your favorite sibling? (could be you)"
		age = gets.strip.to_i
		good_luck = ((u2 % 4 + digit % 4 + age % 5) / 2).to_i
		bad_luck = (((u2 + 1) * (digit + 1) * (age + 1)) % 5).to_i
		puts "You can tell a lot about a person's"
		puts "fortunes with just a few questions."
		return name, good_luck, bad_luck
	end

end
