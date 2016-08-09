


# General Notes:
	# quit from anywhere


#classes
	#person
			#description
				# @first_name
				# @last_name
				# @luck level (if we have time)
	#bankroll (LONNIE)
			#bankroll
				# @bankroll
				# Set balance
				# Check balance
				# Change balance (manual and auto version)
	#games (We may not need this.)
		# initiate method establishes variables only
		# "instructions" method gives instructions
		# "start_game" method actually runs game
			#must return "win" (true/false) and "mult" (multiplier applied to bet in case of win)
		#cards
			# generate deck
			# deal card(s) (must remove from dealable cards)
			# hold dealable cards
			#card games
				# 21 (blackjack)
				# Blitz
				# POKER!!!

		#dice
			# @number of dice
			# roll dice
			# dice
				# dice games
					# Craps

		#chance
			# chance games
				# Slots
				# High / Low (ANDREW)

	#casino (RYAN)
			# switch player
			# switch games
				# for each game round, the casino must:
					# (1) run "instructions" method
					# (2) loop the following
						# ask for a bet
						# run "start_game"
						# calculate change to bankroll and push to bankroll
						# check if the player is out of money 
							# message and quit if yes
			# borrow money (if we have time)
			# betting
			# Game change events
