class Craps
	attr_accessor :game_money, :name, :min
	
	def initialize
		@game_money = 100
		@name = "Craps"
		@min = 10
		
		@pass = ""
		@pass_bet = 0
		@game_point = 0
		
		@odds = false
		@odds_bet = 0
	end

	def instructions
		puts "\n\n********************************"
		puts "WELCOME TO CRAPS!"
		puts "********************************\n\n"
		puts "Choose 'Pass' or 'Dont' to choose your bet type."
		puts "Then enter your bet amount."
		puts "Type 'odds' any time after a a point has been"
		puts "established to place an Odds bet."
		puts "Type 'help' for detailed instructions.\n\n"
	end

	def help
		puts "Pass and Don't Pass Bets:"
		puts "Overall, the 'Pass' route has lower odds, but higher pay out."
		puts "Placing a 'Pass' bet means that you are betting with active player."
		puts "A 'Don't Pass' bet bets against the active player."
		puts "The active player is the player rolling the dice."
		puts "In this game, you are never the active player."
		puts "Press enter to continue."
		gets
		puts "For 'Pass' bets:"
		puts "A roll of 7 or 11 on the come out roll is a win (1:1)."
		puts "A 2, 3 or 12  on the come out result in an instant loss (0:1)."
		puts "A 4, 5, 6, 8, 9, 10  on the come out establish the 'Point'."
		puts "Once a point is established only the 'Point' and 7 matter."
		puts "Re-rolling the Point results in a win (1:1)."
		puts "Rolling a 7 results in a loss (0:1)."
		puts "Press 'enter' to continue."
		gets
		puts "For a 'Don't Pass' bet:"
		puts "A roll of 2 or 3 on the come out roll is a win (1:1)."
		puts "A 7 or 11 on the come out result in an instant loss (0:1)."
		puts "A 12 on the come out results in a tie, with no win or loss."
		puts "A 4, 5, 6, 8, 9, 10 on the come out establish the 'Point'."
		puts "Once a point is established only the 'Point' and 7 matter."
		puts "Re-rolling the Point results in a loss (1:0)."
		puts "Rolling a 7 results in a win (0:1)."
		puts "Press 'enter' to continue."
		gets
		puts "Odds bets:"
		puts "Once a point has been established, you can choose to place"
		puts "an 'Odds' bet."
		puts "This increases the amount of money you are betting that"
		puts "the point or the 7 will come up first (for 'Pass' and 'Don't Pass'"
		puts "bets respectively)."
		puts "The odds for 'Odds' bets vary depending on the point."
		puts "For Pass bets, 4 and 10 have 2:1 odds, 5 and 9 have 3:2 odds"
		puts "and 6 and 8 have 5:6 odds."
		puts "For 'Don't Pass' bets, 4 and 10 have 1:2 odds, 5 and 9 have 2:3"
		puts "and 6 and 8 have 6:5 odds."

		# puts "Press 'enter' to continue."
		# gets
		# puts "Come bets:"
		# puts "Once the 'Pass' or 'Don't Pass' bet have been placed,"
		# puts "and the come out roll has been thrown a player can"
		# puts "place a 'Come' bet."
		# puts "The 'Come' bet is not affected by whether you choose to"
		# puts "place a 'Pass' or 'Don't Pass' bet."
		# puts "Press 'enter' to continue."
		# gets
		# puts "Come bets (cont'd):"
		# puts "A 'Come' bet is a personal 'Pass' bet."
		# puts "All the same rules apply after the point is established."
		# puts "Once the come out roll has been thrown, and a point"
		# puts "has been established, you can place a 'Come' bet at any time."
		# puts "Press 'enter' to continue."
		# gets
		# puts "Come bets (cont'd):"
		# puts "The roll after you place your 'Come' bet determines" 
		# puts "a personal win, loss or point."
		# puts "Just like a 'Pass' bet, 7 is a win, 2, 3, and 12 are a loss,"
		# puts "and 4, 5, 6, 8, 9, 10 establish a point."
		# puts "Remember that the game-wide point is not affected"
		# puts "by the personal point established for your 'Come' bet."
		# puts "Re-rolling the 'Come' point results in a win (1:1)"
		# puts "Rolling a 7 results in a loss (0:1)."
		puts "THE END\n"
	end

	def start
		if @game_money.to_f >= @min.to_f
			puts "\nChoose 'Pass' or 'Dont' or 'out' to Cash Out."
			type = gets.strip.downcase
			case type
			when "dont", "don't"
				@pass = "Don't Pass"
				return pass_bet_fun
			when "pass"
				@pass = "Pass"
				return pass_bet_fun
			when "out", "cash"
				return cash_out
			when "help"
				help
				start
			end
		else 
			puts "Sorry! You don't have enough money to place a bet!"
			puts "Press enter to cash out."
			gets
			return cash_out
		end
		puts "What was that?"
		start
	end

	def pass_bet_fun
		puts "\nEnter the amount for your #{@pass} bet. Or type 'back'."
		puts "Min is $10. Max is $#{'%.02f' % @game_money.to_f}."
		while true
		bet = gets.strip
			if bet == 'back'
				return start
			elsif bet =~ /^\$?\d*\.?\d+$/ && bet.to_f <= @game_money.to_f && bet.to_f >= @min
				@pass_bet = bet.to_f
				puts "\nYou bet $#{'%.02f' % @pass_bet}."
				return come_out_roll
			else
				puts "Please enter a value between the min and max."
			end
		end
	end

	def come_out_roll
		puts "\nPress enter to roll or type 'back' to restart."
		input = gets
		if input.strip == "back"
			@pass_bet = 0
			return start
		end
		@game_money = @game_money.to_f - @pass_bet.to_f
		co = 2 + rand(6) + rand(6)
		puts "Come out roll is...#{co}!"
		if @pass == "Don't Pass"
			case co
			when 2, 3
				@game_money.to_f += @pass_bet * 2
				puts "\nYou won! Your #{@pass} bet of $#{'%.02f' % @pass_bet} returned $#{'%.02f' % (@pass_bet * 2)}."
				puts "You now have $#{'%.02f' % @game_money}."
				return start
			when 7, 11
				puts "\nYour #{@pass} bet lost $#{'%.02f' % @pass_bet}."
				puts "You now have $#{'%.02f' % @game_money}."
				return start
			when 4, 10, 5, 9, 6, 8
				@game_point = co
				puts "\nThe game point is now #{@game_point.to_i}."
				return point_rolls
			else
				@game_money += @pass_bet
				puts "\nA tie! Nobody wins or loses anything."
				puts "You have $#{'%.02f' % @game_money}."
				return start
			end
		elsif @pass == "Pass"
			case co
			when 7, 11
				@game_money += @pass_bet * 2
				puts "\nYou won! Your #{@pass} bet of $#{'%.02f' % @pass_bet} returned $#{'%.02f' % (@pass_bet * 2)}."
				puts "You now have $#{'%.02f' % @game_money}."
				return start
			when 2, 3, 12
				puts "\nYour #{@pass} bet lost $#{'%.02f' % @pass_bet}."
				puts "You now have $#{'%.02f' % @game_money}."
				return start
			when 4, 10, 5, 9, 6, 8
				@game_point = co
				puts "\nThe game point is now #{@game_point.to_i}."
				return point_rolls
			else
				@game_money += @pass_bet
				puts "\nA tie! Nobody wins or loses anything."
				puts "You have $#{'%.02f' % @game_money}."
				return start
			end
		end
	end

	def point_rolls
		print "\nPress enter to roll." 
		puts " Type 'odds' to place an Odds bet." if @game_money >= @pass_bet && @odds == false
		input = gets
		if input.strip.downcase == "odds" && @game_money.to_f >= @pass_bet && @odds == false
			odds_fun
		elsif input.strip.downcase == "odds"
			puts "Whoops! You don't have enough money to place an odds bet."
			point_rolls
		end
		pr = 2 + rand(6) + rand(6)
		puts "The roll is...#{pr}!"
		if pr != @game_point && pr != 7
			point_rolls
		elsif @pass == "Don't Pass" && pr == 7
			@game_money += @pass_bet * 2
			puts "You won! Your #{@pass} bet of $#{'%.02f' % @pass_bet} returned $#{'%.02f' % (@pass_bet * 2)}."
			odds_win
			puts "You now have $#{@game_money}."
			start
		elsif @pass == "Don't Pass" && pr == @game_point
			puts "Your #{@pass} bet lost $#{'%.02f' % @pass_bet}."
			odds_loss
			puts "You now have $#{@game_money}."
			start
		elsif @pass == "Pass" && pr == @game_point
			@game_money += @pass_bet * 2
			puts "You won! Your #{@pass} bet of $#{'%.02f' % @pass_bet} returned $#{'%.02f' % (@pass_bet * 2)}."
			odds_win
			puts "You now have $#{@game_money}."
			start
		elsif @pass == "Pass" && pr == 7
			puts "Your #{@pass} bet lost $#{'%.02f' % @pass_bet}."
			odds_loss
			puts "You now have $#{@game_money}."
			start
		else
			puts "This is impossible!"
		end
	end

	def odds_fun
		puts "\nType in your Odds bet or type 'back' to cancel."
		bettable = @game_money.to_f <= (2 * @pass_bet) ? @game_money.to_f : (2 * @pass_bet)
		puts "You may bet between $#{'%.02f' % @pass_bet} and $#{'%.02f' % bettable}.\n"
		while true
			bet = gets.strip
			if bet == 'back'
				return point_rolls
			elsif bet =~ /^\$?\d*\.?\d+$/ && bet.to_i >= @pass_bet && bet.to_i <= bettable.to_i
				@odds_bet = bet.to_f
				@game_money -= @odds_bet
				puts "\nYour Odds bet is $#{'%.02f' % @odds_bet}."
				@odds = true
				puts "Press enter to roll."
				gets
				return
			else
				puts "Please enter a value between $#{'%.02f' % @pass_bet} and $#{'%.02f' % bettable}."
			end
		end
	end

	def odds_win
		if @odds == true
			puts "You also won your Odds bet!"
		else
			return
		end
		if @pass == "Pass" && @odds == true
			case @game_point.to_i
			when 4, 10
				mult = 3
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 2:1 ratio!"
				@odds = false
				@odds_bet = 0
			when 5, 9
				mult = 2.5
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 3:2 ratio!"
				@odds = false
				@odds_bet = 0
			when 6, 8
				mult = 2.2
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 6:5 ratio!"
				@odds = false
				@odds_bet = 0
			else
				return
			end
		elsif @pass == "Don't Pass" && @odds == true
			case @game_point.to_i
			when 4, 10
				mult = 1.5
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 1:2 ratio!"
				@odds = false
				@odds_bet = 0
			when 5, 9
				mult = 1.667
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 2:3 ratio!"
				@odds = false
				@odds_bet = 0
			when 6, 8
				mult = 1.833
				@game_money += (@odds_bet * mult)
				puts "You won $#{'%.02f' % (@odds_bet * mult)}, a 5:6 ratio!"
				@odds = false
				@odds_bet = 0
			else
				return
			end
		end
	end

	def odds_loss
		if @odds == true
			puts "You also lost your Odds bet..."
			puts "Your Odds bet lost $#{'%.02f' % @odds_bet}."
			@odds = false
			@odds_bet = 0
		else
			return
		end
	end

	def cash_out
		puts "Are you sure you want to cash out? y/n?"
		input = gets.strip.downcase
		case input
		when "y"
			return @game_money.to_f
		when "n"
			puts "Good man! Let's keep playing!"
			return start
		else
			cash_out
		end
	end
end



