require 'pry'
class High_low
  attr_accessor :mult, :game_money, :name, :min_bet, :game_bet
  def initialize
    @mult = 1.1
    @name = 'High Low'
    @min_bet = 1
    @game_money = 500 #game_money
    @game_bet = 0
  end

  def init_rand_num
    @number = 1 + rand(20)
    @num_array = (1..20).to_a
    @number2 = @num_array.sample.to_i
  end
#attr_accessor :num_array


  # def initialize
  # end


  def instructions
    puts ""
    puts "Welcome to High Low! The objective of the game is to predict whether the number that"
    puts "is about to be called is higher or lower then the previous number called. If you think"
    puts "the number next number will be higher then the previous number, type 'High'. If you think"
    puts "the number will be lower then the previous number, type 'Low'. The numbers go from 1 to 20."
    puts "You can cash out at any time by typing 'Cash Out'. Are you ready? Type 'Start' to begin"
    puts "playing or 'Back' to go back to the main menu."
    puts ""
    print "-->"
  end

  def start
    while true
      input = gets.strip.downcase
      if input == 'start'
        bet
      elsif input == 'back'
        exit(0)
      else
        puts ""
        puts "Please type 'Start' to start or 'Back' to go back to the game menu"
      end
    end
  end

    def bet
    puts ""
    puts "How much money would you like to bet?"
    puts "Available balance is #{@game_money}"
    puts ""
    print "--> "

    @game_bet = gets.strip.to_f
    if @game_bet < @min_bet
      puts ""
      puts "Sorry, the minnimum bet is $1.00"
      puts ""
    elsif @game_bet > @game_money
      puts ""
      puts "Sorry, you can't bet that much. Your available"
      puts "balance is #{@game_money}"
      puts ""
      bet
    else
      puts ""
      puts "you have bet #{@game_bet}!"
      puts ""
      @game_money = @game_money - @game_bet
    end
    game
  end

  # def init_array
  # end
  def game
    puts ""
    puts "High or Low?"
    puts ""
    init_rand_num
    puts @number
    #@num_array << @number
    puts ""
    print "-->"
    input = gets.strip.downcase

    case input
    when "high"
      if @number.to_i < @number2.to_i
        puts ""
        puts "The number was #{@number2}!"
        puts "You Win!"
        @mult += 0.1
        puts "Your multiplier is #{@mult.round(2)}!"
        game
      else
        puts "The number was #{@number2}!"
        puts "You Lose!"
        puts "Game Over"
        puts "You lost #{@game_bet}"
        bet

      # true => @number > @num_array.last
      # false => @number < @num_array.last
      end

    when 'low'
      if @number.to_i > @number2.to_i
        puts ""
        puts "The number was #{@number2}!"
        puts "You Win!"
        @mult += 0.1
        puts "Your multiplier is #{@mult.round(2)}!"
        game
      else
        puts "The number was #{@number2}!"
        puts 'You Lose!'
        puts 'Game Over!'
        puts "You lost #{@game_bet}"
        bet
    end

        #true = @number < @num_array.last
        #false = @number > @num_array.last

    when 'cash out'
      puts ""
      puts "Game over!"
      puts ""
      puts "your multiplier is #{@mult.round(2)}"
      @money_won = @mult * @game_bet
      puts "You won $#{@money_won.round(2) - @game_bet.round(2)}!"
      @game_money = @money_won + @game_money
      puts "You now have $#{@game_money}"
      return @game_money

      # return true, @mult


    end
  end
end


hilo = High_low.new
hilo.start
