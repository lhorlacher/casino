require_relative 'deck'

class BlackJack
	attr_accessor :deck, :game_money, :min, :player_total, :dealer_total, :dealer_cards,
				  :player_cards, :dealer_hidden, :bet, :name
	def initialize
		@deck = Deck.new
		@game_money
		@min = 5
		@dealer_cards = []
		@player_cards = []
		@dealer_total = 0
		@player_total = 0
		@dealer_hidden = []
		@bet = 0
		@name = BlackJack
	end

	def instructions
		puts 'Type "help" to see instructions to play.'
		help = gets.strip
		case help
		when 'help'
			puts 'To start, you will place an opening bet.'
			puts "You will then receive two cards and see the dealer's top card."
			puts 'At this point, you can choose to hit or stay'
			puts 'If you stay, you will be given another card.'
			puts 'If you stay, the dealer will turn over his hidden card'
			puts 'and take more cards until his total is over 16.'
			puts 'If the dealer gets a higher score than you without going over 21, you lose.'
			puts 'If you get the higher score, or the dealer goes over 21, you win.'
			puts 'In the case that you get 21 with 3 cards and the dealer gets 21 with two cards, you lose.'
		end
	end

	def start
		if @game_money.to_f <= 5
			puts "You don't have have enough to play this game!"
			return @game_money
		end
		@dealer_cards = []
		@player_cards = []
		@dealer_total = 0
		@player_total = 0
		@dealer_hidden = 0
		puts '============================================'
		puts 'Place your bet or use \'back\' to return to menu.'
		puts "You have \$#{@game_money}"
		while true
			@bet = gets.to_f
			if @bet == 'back'
				@game_money
			elsif @bet < @min
				puts 'Please place a real bet'
			else
				break
			end
		end
		@game_money = @game_money.to_f - @bet.to_f
		deal_first_round
	end

	def deal_first_round
		user_first_card = @deck.deal_card
		puts "Your first card is #{user_first_card}"
		player_card_tracker(user_first_card)
		@dealer_hidden = @deck.deal_card
		puts "Dealer's first card is facedown"
		dealer_card_tracker(dealer_hidden)
		user_second_card = @deck.deal_card
		puts "Your second card is #{user_second_card}"
		player_card_tracker(user_second_card)
		@player_total = card_sum(player_cards)
		puts "You're total so far is #{@player_total}"
		dealer_second_card = @deck.deal_card
		puts "Dealer's second card is #{dealer_second_card}"
		dealer_card_tracker(dealer_second_card)
		if card_sum(player_cards) == 21
			puts "You have blackjack!"
			puts "The dealer turns over his hidden card to reveal: #{@hidden_card}"
			puts "The dealer's total is #{card_sum(dealer_cards)}"
			if card_sum(dealer_cards) == 21
				puts "This is a push! You get your \$#{@bet} back, but don't win any."
				return @game_money = @game_money.to_f + @bet.to_f
			else
				puts "You win!! You bet #{@bet}. You get it back plus another \$#{@bet}!"
				@game_money += (@bet.to_f * 2)
				return start
			end
		else
			hit_or_stay
		end
	end
	def player_card_tracker(card)
		if card[0] == 'A'
			@player_cards << card[0]
		else
			@player_cards.insert(0, card[0])
		end
	end

	def dealer_card_tracker(card)
		if card[0] == 'A'
			@dealer_cards << card[0]
		else
			@dealer_cards.insert(0, card[0])
		end
	end

	def card_sum(hand)
		total = 0
		hand.each do |cards|
			if cards.to_i > 0
				total += cards.to_i
			elsif cards != 'A' && cards.to_i == 0
				total += 10
			else
				if total.to_i >= 11
					total += 1
				else
					total += 11
				end
			end
		end
		total
	end


	def hit_or_stay
		puts 'Hit or stay?'
		hit_stay = gets.strip
		case hit_stay.downcase
		when 'hit'
			new_card = @deck.deal_card
			player_card_tracker(new_card)
			puts "Your new card is #{new_card}"
			puts "Your total is #{card_sum(@player_cards)}"
			if card_sum(@player_cards) > 21
				puts "You bust! You lost \$#{bet}."
				return start
			end
			hit_or_stay
		when 'stay'
			puts "Dealer shows his hidden card.  It is: #{@dealer_hidden}"
			return dealer_hit_or_stay
		else
			puts 'You have to choose hit or stay'
			hit_or_stay
		end
	end

	def dealer_hit_or_stay
		puts "Dealer total is #{card_sum(@dealer_cards)}"
		if card_sum(dealer_cards) == 21
			puts "Dealer Blackjack! Dealer wins! You lose \$#{@bet}"
			return start
		elsif card_sum(@dealer_cards) > card_sum(@player_cards) && card_sum(@dealer_cards) > 16
			puts "Dealer wins with a total of #{card_sum(@dealer_cards)}. You have #{card_sum(@player_cards)}"
			return start
		elsif card_sum(@dealer_cards) < card_sum(@player_cards) && card_sum(@dealer_cards) > 16
			puts "You win!!"
			@game_money += @bet.to_f
			return start
		elsif card_sum(@dealer_cards) < 17
			while true
				puts "Dealer total is #{card_sum(@dealer_cards)}. He takes another card..."
				puts "The new card is #{new_card = @deck.deal_card}"
				dealer_card_tracker(new_card)
				puts "Dealer total is now #{card_sum(@dealer_cards)}"
				if card_sum(@dealer_cards) > card_sum(@player_cards) && card_sum(@dealer_cards) <= 21 && card_sum(@dealer_cards) > 16
					puts "Dealer wins with a total of #{card_sum(@dealer_cards)}. You have #{card_sum(@player_cards)}"
					return start
				elsif card_sum(@dealer_cards) > 21
					puts "Dealer bust! You win!"
					@game_money += (@bet.to_f * 2)
					return start
				elsif card_sum(@dealer_cards) >= 17 && card_sum(@dealer_cards) < card_sum(@player_cards)
					puts "You win!  Dealer: #{card_sum@dealer_cards} You:#{card_sum@player_cards}"
					@game_money += (@bet.to_f * 2)
					return start
				elsif card_sum(@dealer_cards) == card_sum(@player_cards) && card_sum(@dealer_cards) > 16
					puts "Push! Dealer:#{card_sum(@dealer_cards)} You:#{card_sum(@player_cards)}"
					@game_money += @bet.to_f
				else #dealer still under 16
					#allow loop to continue
				end
			end
		end
	end
end












