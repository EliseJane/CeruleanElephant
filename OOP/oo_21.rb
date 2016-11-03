class Participant
  attr_accessor :hand, :name, :break_toggle

  def initialize
    @hand = []
    @name = ''
    @break_toggle = 0
  end

  def to_s
    name
  end

  def >(other_hand)
    total > other_hand.total
  end

  def hit(deck)
    hand << Card.new(deck.deal)
    find_aces
    display_cards
  end

  def find_aces
    aces = hand.select { |card| card.face.include?('Ace') }
    aces.each { |card| card.value = determine_ace }
  end

  def determine_ace
    if busted?
      return 1
    else
      return 11
    end
  end

  def stay
    puts "#{name} chooses to stay."
    puts ""
    @break_toggle += 1
  end

  def busted?
    total > 21
  end

  def busted_message
    puts "#{name} busted!"
    puts ""
    @break_toggle += 1
  end

  def twenty_one?
    total == 21
  end

  def twenty_one_message
    puts "#{name} has 21!"
    puts ""
    @break_toggle += 1
  end

  def total
    hand.map(&:value).inject(:+)
  end
end

class Player < Participant
  def display_cards
    puts "Your hand: #{hand.map(&:face).join(', ')}"
    puts ""
  end

  def round(deck)
    decision = ''
    loop do
      puts "Would you like to hit(h) or stay(s)?"
      decision = gets.chomp.downcase
      break if decision.start_with?('h', 's')
      puts "Please enter a valid choice."
    end

    if decision == 'hit' || decision == 'h'
      hit(deck)
    elsif decision == 'stay' || decision == 's'
      stay
    else
      puts "Did you try to trick me...? I quit!"
      exit
    end
  end

  def turn(deck)
    @break_toggle = 0
    loop do
      round(deck)
      if busted?
        busted_message
      elsif twenty_one?
        twenty_one_message
      end
      break if break_toggle > 0
    end
  end
end

class Dealer < Participant
  def display_cards
    puts "Dealer hand: #{hand.map(&:face).drop(1).unshift('? ').join(', ')}"
    puts ""
  end

  def display_all_cards
    puts "Dealer hand: #{hand.map(&:face).join(', ')}"
    puts ""
  end

  def turn(deck)
    @break_toggle = 0
    loop do
      if total >= 17
        stay
      else
        hit(deck)
        if busted?
          busted_message
        elsif total == 21
          twenty_one_message
        end
      end
      break if break_toggle > 0
    end
  end
end

class Deck
  attr_accessor :remaining_cards

  SUITS = [' of hearts', ' of diamonds', ' of spades', ' of clubs'].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
  CARDS = VALUES.product(SUITS).map(&:join)

  def initialize
    @remaining_cards = CARDS.shuffle
  end

  def deal
    @remaining_cards.shift
  end
end

class Card < Deck
  attr_reader :face, :suit
  attr_accessor :value

  def initialize(card)
    @face = card.to_s
    @suit = face.split.last
    determine_value(face.split.first)
  end

  def determine_value(val)
    @value = case val
             when 'Jack' then 10
             when 'Queen' then 10
             when 'King' then 10
             when 'Ace' then 11
             else val.to_i
             end
  end
end

class Game
  attr_accessor :dealer, :player, :winner

  def initialize
    @dealer = Dealer.new
    @player = Player.new
  end

  def start
    welcome_message
    ask_player_name
    select_dealer_name
    loop do # same participants, can renew deck
      deck = Deck.new
      until deck.remaining_cards.size < 10 # deals hands until deck is low
        deal_cards(deck)
        player.display_cards
        dealer.display_cards
        player.turn(deck)
        dealer.turn(deck) unless player.busted?
        dealer.display_all_cards
        determine_result
        show_result
        discard
      end
      break unless reshuffle?
    end
    goodbye_message
  end

  def welcome_message
    puts "Welcome to Twenty-One!! Do you know how to play?"
    answer = gets.chomp.downcase
    display_rules unless answer.start_with?('y')
  end

  def display_rules
    puts ""
    puts "Twenty-One is a card game consisting of a dealer and a player, where"
    puts "the participants try to get as close to 21 as possible without going"
    puts "over."
    puts ""
    puts "Here is an overview of the game:"
    puts "- Both participants are initially dealt 2 cards from a 52-card deck."
    puts "- The player takes the first turn, and can 'hit' or 'stay'."
    puts "- If the player busts, he loses. If he stays, it's the dealer's turn."
    puts "- The dealer must hit until his cards add up to at least 17."
    puts "- If he busts, the player wins. If both player and dealer stays, then"
    puts "   the highest total wins."
    puts "- If both totals are equal, then it's a tie, and nobody wins."
    puts ""
  end

  def ask_player_name
    loop do
      puts "What is your name?"
      player.name = gets.chomp
      break unless player.name.empty?
      puts "You must have some sort of name...."
      puts ""
    end
  end

  def select_dealer_name
    dealer.name = ["Joe", "Dick", "Don", "Burt", "George", "Tony"].sample
    puts ""
    puts "Welcome, #{player.name}."
    puts "Your dealer and opponent today is #{dealer.name}. Good luck!"
    puts ""
  end

  def deal_cards(deck)
    @winner = 'Nobody'
    2.times do
      player.hand << Card.new(deck.deal)
      dealer.hand << Card.new(deck.deal)
    end
    player.find_aces
    dealer.find_aces
  end

  def determine_result
    if player.busted?
      if !dealer.busted?
        @winner = dealer
      end
    elsif player.twenty_one?
      if !dealer.twenty_one?
        @winner = player
      end
    elsif dealer.busted?
      @winner = player
    elsif dealer.twenty_one?
      @winner = dealer
    else
      @winner = dealer if dealer > player
      @winner = player if player > dealer
    end
  end

  def show_result
    puts "#{winner} wins!!!"
    puts ""
  end

  def discard
    player.hand.clear
    dealer.hand.clear
  end

  def reshuffle?
    puts "You are almost out of cards. Do you want to reshuffle the deck and"
    puts "continue playing?"
    return true if gets.chomp.downcase.start_with?('y')
  end

  def goodbye_message
    puts "Thanks for playing 21!"
    puts "Gambling is an addictive hobby. Practice with care."
    puts ""
  end
end

Game.new.start
