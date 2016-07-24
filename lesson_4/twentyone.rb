require 'pry'

SUITS = ["of hearts", "of spades", "of diamonds", "of clubs"].freeze
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"].freeze

def initialize_deck
  new_deck = Array.new
  SUITS.each do |suit|
    VALUES.each do |value|
      new_deck.push([value, suit])
    end
  end
  new_deck.shuffle!
end

def deal(deck)
  new_hand = Array.new
  new_hand.push(deck.shift)
  new_hand.push(deck.shift)
  new_hand
end

def hit(hand, deck)
  hand.push(deck.shift)
end

def calculate_total(hand)
  total = 0
  values = hand.map { |card| card[0] }
  values.each do |value|
    if value == "Ace"
      total += 1
      total += 10 unless total >= 12
    elsif value == "Jack" || value == "Queen" || value == "King"
      total += 10
    else
      total += value.to_i
    end
  end
  total
end

def busted?(total)
  total > 21
end

def table(player, dealer)
  system 'clear'
  puts "Your hand: #{player}"
  puts "Dealer's hand: unknown  #{dealer.drop(1)}"
end

def find_winner(player, dealer)
  return 'Player' if player <= 21 && (player > dealer || busted?(dealer))

  return 'Dealer' if dealer <= 21 && (dealer > player || busted?(player))

  return 'Everybody' if player == dealer && player <= 21

  return 'Nobody' if player > 21 && dealer > 21
end

def display_stats(phand, dhand, ptotal, dtotal, winner)
  system 'clear'
  puts "Your hand: #{phand}"
  puts "Dealer's hand: #{dhand}"

  puts "21!" if ptotal == 21 || dtotal == 21

  puts "Push!" if ptotal == dtotal

  puts "Bust!" if ptotal > 21 || dtotal > 21

  puts "#{winner} wins!"
end

loop do
  # set up
  deck = initialize_deck
  player_hand = deal(deck)
  dealer_hand = deal(deck)
  player_total = 0
  dealer_total = 0

  # player turn
  loop do
    table(player_hand, dealer_hand)

    player_total = calculate_total(player_hand)
    break if player_total == 21

    dealer_total = calculate_total(dealer_hand)
    break if dealer_total == 21

    break if busted?(player_total)

    puts "Hit or stay? (h or s)"
    decision = gets.chomp
    break unless decision.downcase.start_with?("h")
    hit(player_hand, deck)
  end

  # dealer turn
  loop do
    break if busted?(dealer_total)

    while dealer_total < 17
      hit(dealer_hand, deck)
      table(player_hand, dealer_hand)
      dealer_total = calculate_total(dealer_hand)
    end

    break
  end

  # find and display winner
  winner = find_winner(player_total, dealer_total)
  display_stats(player_hand, dealer_hand, player_total, dealer_total, winner)

  # play again?
  puts "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?("y")
end

puts "Good bye!"
