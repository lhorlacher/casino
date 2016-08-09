class Craps
	attr_accessor :game_money, :name, :min_bet
	
	def initialize
		@game_money = 0
		@name = "Craps"
		@min_bet = 10
	end

	def instructions
		puts "Place a 'Pass' Bet or a 'Don't' Pass Bet"
		puts "Overall, the 'Pass' route has lower odds, but higher pay out."
		puts "Type 'come' at any time to place a come bet or 'help' for detailed help."
	end

	def help
		puts "Placing a 'Pass' bet means that you are betting with active player."
		puts "A 'Don't Pass' bet bets against the active player."
		puts "The active player is the player rolling the dice."
		puts "In this game, you are never the active player."
		puts "Press enter to continue."
		gets
		puts "For 'Pass' bets:"
		puts "A roll of 7 or 11 on the come out roll is a win (1:1)."
		puts "A 2, 3 or 12 result in an instant loss (0:1)."
		puts "A 4, 5, 6, 8, 9, 10 establish the 'Point'."
		puts "Once a point is established only the 'Point' and 7 matter."
		puts "Re-rolling the Point results in a win (1:1)."
		puts "Rolling a 7 results in a loss (0:1)."
		puts "Press 'enter' to continue."
		gets
		puts "For a 'Don't Pass' bet:"
		puts "A roll of "


	def start
