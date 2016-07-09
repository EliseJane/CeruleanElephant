#	get loan amount
#	get APR
#	get loan duration
#	calculate monthly interest rate
#	calculate loan duration in months

puts "Please enter the amount of your loan in whole dollars:"
loan = gets.chomp.to_i
puts "Please enter your APR as a decimal (ex. 4.5% = .045):"
apr = gets.chomp.to_f
monthly = apr/12
puts "How many years will you be paying this loan?"
duration = gets.chomp.to_f
months = duration*12

payment = loan*(monthly*(1 + monthly)**months)/((1 + monthly)**months - 1)

puts "You will be paying #{payment} dollars every month for #{months} months."