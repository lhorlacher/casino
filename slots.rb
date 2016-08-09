# require 'pry'
# require 'colorize'

class Slots
	def initialize
		@spool1 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@spool2 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@spool3 = ['cherries', 'grapes', 'oranges', 'apples', 'bannana', 'peach']
		@min = 1.00
	end

	def instructions
		puts 'This is a simple game! Just spin the wheel to find out if you win!'
		puts 'Each spin costs $1.00.'
		puts 'Hit enter to spin!'
	end
	def start
		result = []
		spin = gets
		case spin
		when "\n"
			result = [@spool1.sample, @spool2.sample, @spool3.sample]
			if result[0] == result[1] && result[0] == result[2]
				puts "#{result[0]} | #{result[1]} | #{result[2]}"
				puts 'YOU WON $32.00!!'
				puts 'Hit enter to spin again or quit to exit'
				32
			else
				puts result
				puts 'No win here'
				puts 'Hit enter to spin again or quit to exit'
				-1
			end
		when 'quit'
			spin.strip		
		else
			puts 'Just hit enter.  Not too hard...'
		end
	end
end

slots = Slots.new
while true
slots.instructions
slots.start
end
