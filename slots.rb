# require 'pry'
# require 'colorize'

class Slots
	attr_accessor :name, :min, :game_money
	def initialize
		@spool1 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@spool2 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@spool3 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@min = 1.00
		@name = 'Slots'
		@game_money = 1
	end

	def instructions
		puts 'This is a simple game! Just spin the wheel to find out if you win!'
		puts 'Each spin costs $1.00.'
	end
	def start
		if @game_money.to_f > @min.to_f
			puts 'Hit enter to spin or "cash out" to go back.'
			result = []
			spin = gets
			case spin
			when "\n"
				@game_money = @game_money.to_f - 1
				result = [@spool1.sample, @spool2.sample, @spool3.sample]
				if result[0] == result[1] && result[0] == result[2]
					puts "#{result[0]} | #{result[1]} | #{result[2]}"
					puts 'YOU WON $32.00!!'
					puts 'Hit enter to spin again or quit to exit'
					@game_money = @game_money.to_f + 32
				else
					puts result
					puts 'No win here'
				end
			when /^cas\.*/
				return @game_money
				exit(0)
			else
				puts 'Just hit enter.  Not too hard...'
			end
		else
			puts 'You are out of money for this game!'
			puts '-----------------------------------'
			exit (0)
		end
	end
end

