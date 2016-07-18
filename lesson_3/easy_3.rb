#Question 1:
p flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

#Question 2:
p flintstones << "Dino"

#Question 3:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.concat( ["Dino", "Hoppy"] )
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.push("Dino", "Hoppy")

#Question 4:
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(0..38)
p advice

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice(0..38)
p advice

#or
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(0, advice.index('house'))
p advice

#Question 5:
statement = "The Flintstones Rock!"
p statement.count('t')
#or
p statement.scan('t').count

#Question 6:
title = "Flintstone Family Members"
p title.center(40)
