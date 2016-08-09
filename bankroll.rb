# require 'pry'
# require 'colorize'

class Bankroll
	attr_accessor :bankroll

	def initialize
		@starting_value, @bankroll = setup
		@mom = true
		@mom_budget = 1 + rand(200)
		@history = []
		@boss_time = 10
		@sad_words1 = ["child", "children", "kids", "baby", "little", "grankids"]
		@sad_sords2 = ["died", "dying", "lost", "scared", "hungry", "starving", "hurt", "please", "sorry", "thank", "thanks"]
	end

	def setup 
		puts "How much money do you have in your pocket?"
		while true
			 input = gets.strip
			if input =~ /^\$?\d*\.?\d+$/
				starting_value = input.gsub(/\$/, "").to_f
				bankroll = input.gsub(/\$/, "").to_f
				puts "Your bankroll has been set to: #{'%.02f' % bankroll}."
				return starting_value, bankroll
				break
			else
				puts "Please enter a dollar amount larger than $0."
			end
		end
	end

	def game_result(money_commit, money_final, game_name)
		@bankroll = @bankroll.to_f - money_commit.to_f + money_final.to_f
		difference = money_final.to_f - money_commit.to_f
		@history.push([game_name, difference.to_f, @bankroll.to_f])
	end

	def check_balanace
		puts @history
		puts "Your current balance is $#{'%.02f' % @bankroll}."
		puts "You started with $#{'%.02f' % @starting_value}."
		difference = @starting_value - @bankroll
		if difference >= 0
			puts "To date you have lost $#{'%.02f' % difference}."
		elsif difference < 0
			puts "To date you have won $#{'%.02f' % difference}."
		end
		puts "Press enter to return to menu."
		gets
	end

	def money_options
		puts "You can lie to your mom and ask for money..."
		puts "You could also ask \"the boss\" behind the casino..."
		puts "Type 'mom', 'boss' or save your dignity and type 'back'."
		while @mom == true
			nav = gets.strip.downcase
			case nav
			when "mom" && @mom == true
				mom_excuse
				break
			when "mom" && @mom == false
				puts "Sorry, dear. I am out..."
			when "boss"
				boss_decision
				break
			when "back"
				puts "Whew... Good call."
			break
			else
				puts "What was that?"
			end
		end
	end	

	def mom_excuse
		puts "Hi honey. What's the problem?"
		puts "**Hint: She loves her grandkids mmore than you.**"
		excuse_count = 0
		while excuse_count < 2
			excuse_count += 1
			excuse = gets.strip.downcase
			if (excuse.split & @sad_words1).any? && (excuse.split & @sad_words2).any?
				excuse = (50 * (excuse.split & @sad_words1 + @sad_words2).length)
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
				game_result(0, "Mom")
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
				game_result(dollars.to_f, "Mom")
			elsif money_count < 2
				puts "I am sure you don't need that much."
				puts "How much do you really need?"
			else
				puts "That's just too much. Sorry."
				puts "I will just have to fly out. See you in 6 hours!"
				game_result(0, "Mom")
			end
		end
	end

	def boss_decision
		puts "Huh. You don't look real reliable."
		puts "How do I know I will get my money back?"
		puts "Options: laugh, reassure, stutter"
		action = gets.strip.downcase
		case action
		when "laugh"
			puts "Ok. How much do you need?"
			amount = gets.strip.to_f
		else
			puts "PLACEHOLDER"
		end
	end





end







