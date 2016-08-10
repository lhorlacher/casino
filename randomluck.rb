class Luck
	attr_accessor
	def initialize
		@good_luck_phrases = [
			['You found a chip on the ground!', 20],
			['A creepy guy hands you some chips and calls you his "good luck charm..."', 40],
		 	['A quick Keno ticket wins you some money!', 50],
		 	['You complain about some bad food and the casino comps you!', 10],
		 	['Your significant other gets tired and gives you their remaining chips!', 10]
		 ]
		@bad_luck_phrases = [
			["You accicentally gave the cocktail waitress a huge tip.", 40],
			["That drunk guy just gave you a hug! It also seems he took your wallet...", 50], 
			["You dropped your chips!  You found most of them...", 20], 
			['In a moment of excitement, you give a chip to a bystander for luck.', 10],
			['You really should be more careful.', 10]
		]
		@goodbad_array = [0, 1, 2, 3, 4]
		@choose_outcome_array = [0, 1, 2, 3, 4]
	end

	def good_or_bad(good_luck, bad_luck)
		match = @goodbad_array.sample
		index = @choose_outcome_array.sample
		if match == good_luck
			puts "#{@good_luck_phrases[index][0]}" 
			puts "You got \$#{@good_luck_phrases[index][1]}!"
			puts '===================================='
			@good_luck_phrases[index][1]
		elsif match == bad_luck
			puts "#{@bad_luck_phrases[index][0]}"
			puts "You lost \$#{@bad_luck_phrases[index][1]}!"
			puts '===================================='
			-(@bad_luck_phrases[index][1])
		end
	end
end

