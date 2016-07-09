VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'spock' && second == 'scissors')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def score(player, computer)
	if win?(player, computer)
		$player_score += 1
	elsif win?(computer, player)
		$computer_score += 1
	end
end

$player_score = 0
$computer_score = 0

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp
    
    if choice == 'r'
    	choice = 'rock'
    elsif choice == 'p'
    	choice = 'paper'
    elsif choice == 'l'
    	choice = 'lizard'
    elsif choice == 'sp'
    	choice = 'spock'
    elsif choice == 'sc'
    	choice = 'scissors'
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)
  score(choice, computer_choice)
  if $player_score == 5
  	prompt("You win everything!")
  	$player_score = 0
  	$computer_score = 0
  elsif $computer_score == 5
  	prompt("The computer wins everything!")
  	$player_score = 0
  	$computer_score = 0
  end
  
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")