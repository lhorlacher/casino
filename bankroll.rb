# require 'pry'
# require 'colorize'

class Bankroll
	attr_accessor :bankroll

	def initialize
		@starting_value = 300
		@bankroll = 300
		@mom = true
		@mom_budget = 1 + rand(200)
		@history = []
		@boss_time = 10
		@trivia = true
		@trivia_questions = [
			["During the Great Plague, what was painted on the front doors of plague ridden houses?", "cross"],
			["Which Barbadian singer stayed ten weeks at number 1 with `Umbrella`?", "rihanna"],
			["Genghis Khan founded which empire?", "mongol"],
			["What is a more common name for the Aurora Borealis?", "northern lights"],
			["Who painted the famous painting The Scream?",  "edward munch"],
			["What is the third book of the Bible?", "leviticus"],
			["In cycling, what colour jersey is awarded to the leader in a stage race of the Tour de France?", "yellow"],
			["What is the lightest chemical element?", "hydrogen"],
			["Which author created Elinor Dashwood, Emma Woodhouse and Catherine Morland?", "jane austen"],
			["In horse racing, what betting odds are known as a `carpet`? (format x-y)", "3-1"],
			["Who had a number one hit single in 1964 with `Little Red Rooster`?",  "rolling stones"],
			["The does the chemical symbol Pb stand for?", "lead"],
			["Who wrote the novel `Fantastic Mr. Fox`?", "roald dahl"],
			["Which american state has a name that ends in three vowels?", "hawaii"],
			["In what sport do players take long and short corners?", "Hockey"]
		]
		setup
	end

	def setup 
		puts "\nYou have 300 in your bankroll."
		puts "If you run out, you may have other options..."
	end

	def game_result(money_commit, money_final, game_name)
		@bankroll = @bankroll.to_f - money_commit.to_f + money_final.to_f
		difference = money_final.to_f - money_commit.to_f
		@history.push([game_name, difference.to_f, @bankroll.to_f])
		puts @h
	end

	# def check_balance
	# 	puts "History"
	# 	puts "Game Name---Result---New Balance"
	# 	@history.each do |arr|
	# 		puts "#{arr[0]}---$#{'%.02f' % arr[1]}---$#{'%.02f' % @arr[2]}"
	# 	end
	# 	puts "Your current balance is $#{'%.02f' % @bankroll}."
	# 	puts "You started with $#{'%.02f' % @starting_value}."
	# 	difference = @bankroll - @starting_value
	# 	if difference >= 0
	# 		puts "To date you have lost $#{'%.02f' % difference}."
	# 	elsif difference < 0
	# 		puts "To date you have won $#{'%.02f' % difference}."
	# 	end
	# 	puts "Press enter to return to menu."
	# 	gets
	# end

	def money_options
		puts "\n\nYou can lie to your mom and ask for money..."
		puts "You can ask \"the boss\" behind the casino..."
		# puts "Or you can be humiliated on a game show..."
		puts "Type 'mom' or 'boss' or save your dignity and type 'back'."
		while @mom == true
			nav = gets.strip.downcase
			case nav
			when "mom" && @mom == true
				mom_excuse
				break
			when "mom" && @mom == false
				puts "Sorry, dear. I am out..."
			when "boss" && @boss == true
				boss_decision
				break
			when "boss" && @boss == false
				puts "Come back when you have the rest of my money!"
			# when "game", "show", "game show" && @game_show == true
			# 	game_show
			# when "game", "show", "game show" && @game_show == false
			# 	puts "Sorry. We can't have you back on the show."
			when "back"
				puts "Whew... Good call."
			break
			else
				puts "What was that?"
			end
		end
	end	

	def mom_excuse
		sad_words1 = ["child", "children", "kids", "baby", "little", "grankids"]
		sad_words2 = ["died", "dying", "lost", "scared", "hungry", "starving", "hurt", "please", "sorry", "thank", "thanks"]
		puts "Hi honey. What's the problem?"
		puts "**Hint: She loves her grandkids mmore than you.**"
		excuse_count = 0
		while excuse_count < 2
			excuse_count += 1
			excuse = gets.strip.downcase
			if (excuse.split & sad_words1).any? && (excuse.split & sad_words2).any?
				excuse = (50 * (excuse.split & sad_words1 + sad_words2).length)
				@mom_budget += excuse
				excuse_count = 2
				mom_money
			elsif excuse_count < 2
				puts "Oh, is that all? I am not sure I can help..."
				puts "**Try a different excuse**"
			else
				puts "I don't get the sense that you are being honest."
				puts "Sorry. I can't help this time."
				@mom = false
				game_result(0, 0, "Mom")
				return money_options
			end
		end
	end


	def mom_money
		puts "Oh, that's terrible! How much do you need?"
		puts "**Hint: If you are too greedy, she won't help**"
		money_count = 0
		while money_count < 2
		money_count += 1
			dollars = gets.strip
			puts dollars
			if dollars =~ /^\$?\d*\.?\d+$/ && dollars.to_f >= 0.0 && dollars.to_f <= @mom_budget.to_f
				puts "Sure, dear. I just wired you the money. Check your account."
				@mom = false
				money_count = 2
				game_result(0, dollars.to_f, "Mom")
				return money_options
			elsif money_count < 2
				puts "I am sure you don't need that much."
				puts "How much do you really need?"
			else
				puts "That's just too much. Sorry."
				puts "I will just have to fly out. See you in 6 hours!"
				@mom = false
				game_result(0, 0, "Mom")
				return money_options
			end
		end
	end

	def boss_decision
		boss_mood = 0
		puts "\nHuh. You don't look real reliable."
		puts "\nHow do I know I will get my money back?"
		puts "Options: laugh, reassure, stutter"
		action = gets.strip.downcase
		case action
		when "laugh"
			puts "The boss lightens up."
			boss_mood += 2
		when "reassure"
			puts "The boss doesn't react."
			boss_mood += 1
		when "stutter"
			puts "The boss scowls."
		else
			puts "The boss scowls."
		end
		puts "\nWhen will you pay me back?"
		puts "Options: tomorrow, soon, next week"
		action = gets.strip.downcase
		case action
		when "soon"
			puts "The boss nods."
			boss_mood += 2
		when "next week"
			puts "The boss shrugs."
			boss_mood += 1
		when "tomorrow"
			puts "Yeah.... right."
		else
			puts "The boss scowls."
		end
		puts "\nWhat do you need this money for?"
		puts "Options: food, medical bills, mortgage" 
		action = gets.strip.downcase
		case action
		when "food"
			puts "The boss laughs out loud."
			boss_mood += 1
		when "medical bills"
			puts "The boss nods."
			boss_mood += 2
		when "mortgage"
			puts "The boss looks disappointed."
		else
			puts "The boss scowls."
		end
		puts "\nThis is your last chance to back out..."
		puts "Options: run away, give an excuse, ask for money"
		action = gets.strip.downcase
		case action
		when "ask", "ask for money", "money"
			if boss_mood >= 5
				puts "\nThe boss seems to be in a decent mood."
				puts "He gives you $500 and says to pay him back next week."
				game_result(@bankroll, (@bankroll + 300), "Boss")
				@bankroll += 300
				@boss = false
			elsif boss_mood == 4 || boss_mood == 3
				puts "\nThe boss doesn't seem to like you much."
				puts "He gives you $100 and says to pay him back asap."
				game_result(@bankroll, (@bankroll + 100), "Boss")
				@bankroll += 100
				@boss = false
			else
				puts "\nThe boss changed his mind."
				puts "His thugs jump you when you try to leave."
				puts "You lose half your money...."
				game_result(@bankroll, (@bankroll / 2), "Boss")
				@bankroll = @bankroll / 2
				@boss = false
			end
		when "run", "run away", "give", "excuse", "give an excuse", "give excuse"
			if boss_mood >= 5
				puts "\nThe boss is disappointed that you refuse his generosity..."
				puts "He insists. Firmly. You get $100 that you didn't want."
				game_result(@bankroll, (@bankroll + 100), "Boss")
				@bankroll += 100
				@boss = false
			elsif boss_mood == 4 || boss_mood == 3
				puts "\nThe boss let's you leave without consquences."
				puts "He shouts that you need to watch your back."
				game_result(@bankroll, (@bankroll), "Boss")
				@bankroll += 0
				@boss = false
			else
				puts "\nThe boss is very, very.....very sad."
				puts "His thugs jump you when you try to leave."
				puts "You lose half your money...."
				game_result(@bankroll, (@bankroll / 2), "Boss")
				@bankroll = @bankroll / 2
				@boss = false
			end

		return money_options
	end
end



	# def game_show
	# 	winnings = 0
	# 	question_value = 50
	# 	puts "Welcome to the Game Show!\n"
	# 	puts "Answer the following questions to win!"
	# 	puts "Press enter to hear your first question."
	# 	gets
	# 	puts "\nQuestion 1..."
	# 	q = rand(15).to_i
	# 	puts "#{@trivia_questions[q][0]}."
	# 	answer = gets.strip.downcase.gsub(/\s*/, "")
	# 	if @trivia_questions[q][1].strip.downcase.gsub(/\s*/, "") == answer
	# 		winnings += winnings + question_value
	# 		puts "You are correct! You won $#{'%.02f' % question_value}!."
	# 	else
	# 		puts "Sorry that is incorrect... You won $#{'%.02f' % winnings}!."
	# 	end
	# 	puts "You can 'walk' away now or try another 'question'."
	# 	puts "Type walk or question to continue."
	# 	case action
	# 	when "walk", "walk away", "walkaway"
	# 		if winnings == 50
	# 			puts "Well, here is a consolation prize of $#{'%.02f' % winnings}."
	# 			return game_result(0, winnings, "Game Show")
	# 		else
	# 			puts "Congratulations! You won $#{'%.02f' % winnings}."
	# 			return game_result(0, winnings, "Game Show")
	# 		end
	# 	else
	# 		puts "Sounds like you want another question!"
	# 	end

end










