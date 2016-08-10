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
		@result = []
	end

	def instructions
		puts 'This is a simple game! Just spin the wheel to find out if you win!'
		puts 'Each spin costs $1.00.'
	end
	def start
		while @game_money.to_f >= @min.to_f
			puts 'Hit enter to spin or "cash out" to go back.'
			spin = gets
			case spin
			when "\n"
				result = [@spool1.sample, @spool2.sample, @spool3.sample]
					puts "#{result[0]} | #{result[1]} | #{result[2]}"
				if result[0] == result[1] && result[0] == result[2]
					puts 'YOU WON $15.00!!'
					puts 'Hit enter to spin again or quit to exit'
					@game_money = @game_money.to_f + 32
				elsif result[0] == result[1] || result[1] == result[2] || result[0] == result[2]
					puts 'Meh.  You got your money back'
					puts 'Hit enter to spin again or quit to exit'
					@game_money = @game_money.to_f + @min.to_f
				else
					puts 'No win here'
				end
				@game_money = @game_money.to_f - 1
				puts @game_money
			when /^cas\.*/
				puts "You cashed out with \$#{@game_money}"
				return @game_money
			else
				puts 'Just hit enter.  Not too hard...'
			end
		end
		puts 'You are out of money for this game!'
		puts '-----------------------------------'
		return @game_money
	end
end

