class Deck
 # Getter and Setter methods for rank, suit and color
 attr_accessor :cards, :card_index

 # Gets called when you call the new method to create an instance
 # deck = Deck.new
 def initialize
   @ranks = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
   @suits = ['Spades', 'Diamonds', 'Clubs', 'Hearts']
   @cards = []
   @card_index = (0..51).to_a
 end
 
 def generate_deck
   @suits.each do |suit|
     @ranks.size.times do |i|
       if suit == 'Spades' || suit == 'Clubs'
          color = 'Black'
        else
          color = 'Red'
        end
       @cards << [@ranks[i], suit, color]
     end
   end
 end

  def deal_card
    index = @card_index.sample
    @card_index.pop
    new_card = @cards.delete_at(index)
  end
end

