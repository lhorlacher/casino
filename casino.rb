require_relative 'player'
require_relative 'bankroll'
require_relative 'high-low'
require_relative 'slots'
# require 'pry'
# require 'colorize'


class Casino

	def initialize
		@games = []
		@game_index = nil
		@players_list = []
		@player = nil
		puts 'Welcome to the Casino!'
		@games = [Slots.new, High_low.new]
		main_menu
		# create_player
	end

	def main_menu
		puts '1. View games'
		puts '2. Check bankroll'
		puts '3. Desperate for cash?'
		puts '4. Switch player'
		puts '5. Create new player'
		puts '6. Quit casino'
		while true
			user_input = gets.to_i
			if user_input > 5 || user_input == 0
				puts 'Please choose a number'
			else
				break
			end
		end
		case user_input.to_s
		when '1'
			choose_game
		when '2'
			if @player == nil
				puts 'No player selected to check bankroll.'
			else
				puts "#{@player.bankroll.bankroll}"
			end
			main_menu
		when '3'
			get_more_money
		when '4'
			switch_player
		when '5'
			create_player
		when '6'
			quit
		end
	end

	def create_player
		@players_list << Player.new
		puts 'Use this player? (y/n)'
		while true
			user_choice = gets.strip
			case user_choice
			when /^y.*/
				@player = @players_list.last
				puts "Now playing as #{@players_list.last.name}"
				main_menu
			when /^n.*/
				puts "You created a player, but have chosen not to use '#{@players_list.last.name}"
				main_menu
			else
				puts 'Please choose yes or no.'
			end
		end
	end

	def get_more_money
		@player.bankroll.money_options
		main_menu
	end

	def switch_player
		if @players_list.empty?
			puts 'No players created yet'
			main_menu
		end
		puts 'Which player would you like to use?'
		x = 1
		@players_list.each do |player|
			puts "#{x}. #{player.name} --- #{player.bankroll.bankroll}"
			x += 1
		end
		while true
		user_input = gets.strip
			if user_input.to_i == 0 || user_input.to_i > @players_list.count
				puts 'Please choose a number to select a player'
			else
				break
			end
		end
		@player = @players_list[user_input.to_i - 1]
		puts "Now playing as #{@players_list[user_input.to_i - 1].name}"
		main_menu
	end

	def choose_game
		if @players_list.length < 1
			puts 'You must create a player first.'
			main_menu
		end
		num = 1
		puts 'Which game would you like to play?'
		puts "You are playing as #{@player.name} with \$#{@player.bankroll.bankroll}"
		@games.each do |games|
			puts "#{num}. #{games.name}"
			num += 1
		end
		while true
			choice = gets.strip
			menu_options(choice)
			if choice.to_i <= 0 || choice.to_i > num
				puts 'Please choose a number from the menu'
			else
				@game_index = choice.to_i - 1
				play_game
			end
		end
	end

	def play_game
		if @games[@game_index].min > @player.bankroll.bankroll
			puts "I'm sorry, the minimum bet for #{@games[game_choice].name} is \$#{@games[game_choice].min}."
			puts "You only have \$#{@bankroll.bankroll}."
			choose_game
		end
		while true
			while true
				puts "How much money of your \$#{@player.bankroll.bankroll} would you like to play here?"
				money_commit = gets.strip
				bet_options(money_commit)
				if money_commit.to_f > @player.bankroll.bankroll
					puts "You don\'t have that much! You must play less than \$#{@player.bankroll.bankroll}."
				else
					break
				end
			end
			@games[@game_index].instructions
			@games[@game_index].game_money = money_commit
			game = @games[@game_index].name
			returned_money = @games[@game_index].start
			@player.bankroll.game_result(money_commit, returned_money, game)
			main_menu
		end
	end

	def bet_options(user_input)
		case user_input.strip.downcase
		when /bac.*/
			choose_game
		when /^\$?\d*\.*\d+$/

		else
			puts 'Enter an amount or use "back" to return to menu.'
		end
	end

	def menu_options(user_input)
		case user_input.strip.downcase
		when /check.*/
			@bankroll.check_balance
			choose_game
		when /bac.*/
			main_menu
		end
	end

	def quit
		exit(0)
	end
end


Casino.new
