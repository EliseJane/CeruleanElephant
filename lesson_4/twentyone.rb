# still doesn't puts "Blackjack!"

require 'pry'

SUITS = ["of hearts", "of spades", "of diamonds", "of clubs"].freeze
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"].freeze
LIMIT = 21

def initialize_deck
  VALUES.product(SUITS).shuffle
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
    total += if value == "Ace"
               11
             elsif value == "Jack" || value == "Queen" || value == "King"
               10
             else
               value.to_i
             end
  end
  values.select { |value| value == "Ace" }.count.times do
    total -= 10 if total > LIMIT
  end
  total
end

def busted?(total)
  total > LIMIT
end

def blackjack?(total, hand)
  total == LIMIT && hand.count == 2
end

def table(player, dealer)
  system 'clear'
  puts "Your hand: #{player}"
  puts "Dealer's hand: unknown  #{dealer.drop(1)}"
end

def find_winner(player, dealer)
  return 'Player' if player <= LIMIT && (player > dealer || busted?(dealer))

  return 'Dealer' if dealer <= LIMIT && (dealer > player || busted?(player))

  return 'Everybody' if player == dealer && player <= LIMIT

  return 'Nobody' if player > LIMIT && dealer > LIMIT
end

deck = initialize_deck
player_score = 0
dealer_score = 0

loop do
  # deal
  player_hand = deal(deck)
  dealer_hand = deal(deck)
  player_total = 0
  dealer_total = 0

  # player turn
  loop do
    table(player_hand, dealer_hand)

    player_total = calculate_total(player_hand)
    dealer_total = calculate_total(dealer_hand)

    break if blackjack?(dealer_total, dealer_hand) ||
             blackjack?(player_total, player_hand)

    decision = nil
    loop do
      puts "Hit or stay? (h or s)"
      decision = gets.chomp.downcase
      break if decision == 'h' || decision == 's' ||
               decision == "hit" || decision == "stay"
      puts "Please enter 'h' for hit or 's' for stay."
    end
    break if decision == 's' || decision == "stay" || busted?(player_total)

    hit(player_hand, deck)
  end

  # dealer turn
  loop do
    dealer_total = calculate_total(dealer_hand)
    break if dealer_total >= (LIMIT - 4)

    hit(dealer_hand, deck)
    table(player_hand, dealer_hand)
  end

  # find and display winner
  winner = find_winner(player_total, dealer_total)

  # keep score
  if winner == 'Player'
    player_score += 1
  elsif winner == 'Dealer'
    dealer_score += 1
  end

  # display stats
  system 'clear'
  puts "Your hand: #{player_hand}"
  puts "Dealer's hand: #{dealer_hand}"
  puts "Blackjack!" if blackjack?(dealer_total, dealer_hand) ||
                       blackjack?(player_total, player_hand)

  puts "#{LIMIT}!" if player_total == LIMIT || dealer_total == LIMIT
  puts "Push!" if player_total == dealer_total
  puts "Bust!" if player_total > LIMIT || dealer_total > LIMIT

  puts "#{winner} wins!"
  puts "Player's score is #{player_score}. Dealer's score is #{dealer_score}."

  break if player_score == 5 || dealer_score == 5

  # play again?
  answer = nil
  loop do
    puts "Do you want to play again (y or n)?"
    answer = gets.chomp.downcase
    break if answer == 'y' || answer == 'n' || answer == "yes" || answer == "no"
    puts "Please enter 'y' for yes or 'n' for no."
  end
  break if answer == 'n' || answer == "no"

  # reshuffle deck when low
  deck = initialize_deck if deck.count < 10
end

puts "Good bye!"
