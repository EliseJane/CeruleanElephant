#Question 1:
p ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.include?("Spot")
p ages.has_key?("Spot")
p ages.member?("Spot")

#Question 2:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
total = 0
ages.each_value { |age| total = total + age }
p total
#or
p ages.values.inject(:+)

#Question 3:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.keep_if { |name, age| age < 100 }

#Question 4:
munsters_description = "The Munsters are creepy in a good way."
p munsters_description.capitalize
p munsters_description.swapcase
p munsters_description.downcase
p munsters_description.upcase

#Question 5:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
p ages.merge!(additional_ages)

#Question 6:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
p ages.values.min

#Question 7:
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("Dino")
p advice.include?("dino")
#or
p advice.match("dino")

#Question 8:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.find_index { |name| name.downcase.start_with?("be") }
#or
p flintstones.index { |name| name[0, 2] == "Be" }

#Question 9:
p flintstones.map! { |name| name[0..2] }

#Question 10: same as above!