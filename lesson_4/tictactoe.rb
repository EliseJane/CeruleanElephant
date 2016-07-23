require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze
FIRST_PLAYER = 'Choose' # rubocop:disable Style/MutableConstant

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  prompt "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_marks_square!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

# rubocop:disable Metrics/CyclomaticComplexity
def computer_marks_square!(brd)
  square = nil

  WINNING_LINES.each do |line|
    square = win_or_block(line, brd, COMPUTER_MARKER)
    break if square
  end

  if square.nil?
    WINNING_LINES.each do |line|
      square = win_or_block(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  square = 5 if brd[5] == INITIAL_MARKER && square.nil?
  square = empty_squares(brd).sample if square.nil?
  brd[square] = COMPUTER_MARKER
end
# rubocop:enable Metrics/CyclomaticComplexity

def win_or_block(ln, brd, mrkr)
  if brd.values_at(*ln).count(mrkr) == 2
    brd.select { |k, v| ln.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(arr, div= ', ')
  arr[-1] = "or #{arr.last}" if arr.size > 1
  arr.size == 2 ? arr.join(' ') : arr.join(div)
end

def mark_square!(brd, plyr)
  if plyr == 'Player'
    player_marks_square!(brd)
  elsif plyr == 'Computer'
    computer_marks_square!(brd)
  end
end

player_score = 0
computer_score = 0

loop do
  board = initialize_board
  current_player = ''
  other_player = ''
  # determine first player based on value of constant
  loop do
    case FIRST_PLAYER
    when 'Computer'
      current_player = 'Computer'
      other_player = 'Player'
      break
    when 'Player'
      current_player = 'Player'
      other_player = 'Computer'
      break
    when 'Choose'
      prompt "Who is going first? Player or Computer?"
      FIRST_PLAYER = gets.chomp.downcase.capitalize
    end
  end

  loop do
    display_board(board)

    mark_square!(board, current_player)
    current_player, other_player = other_player, current_player
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    prompt "#{winner} won!"
    if winner == 'Player'
      player_score += 1
    elsif winner == 'Computer'
      computer_score += 1
    end
  else
    prompt "It's a tie!"
  end

  prompt "You have #{player_score} and the computer has #{computer_score}"
  break if player_score == 5 || computer_score == 5

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye."
