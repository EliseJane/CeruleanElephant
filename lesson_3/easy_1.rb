=begin

Question 1: 1
						2
						2
						3

Question 2: ! usually makes a permanent change. ? usually inquires about something.
1) != is a comparative operator that means NOT equal to
2) NOT something, which would always be false
3) permanently replaces words with just the unique words
4) error
5) can't just be added onto anything. some methods have an inquiry quality signified by the ?
6) NOT NOT something, which would always be true

=end

#Question 3:
p advice = "Few things in life are as important as house training your pet dinosaur."
p advice.sub!('important', 'urgent')

#Question 4:
numbers = [1, 2, 3, 4, 5]
p numbers.delete_at(1) #deletes value at index 1, the second place. returns deleted value.
numbers = [1, 2, 3, 4, 5]
p numbers.delete(1) #deletes the value 1. returns deleted value.

#Question 5:
p (10..100).include?(42)

#Question 6:
famous_words = "seven years ago..."
p "Four score and " + famous_words

famous_words = "seven years ago..."
p famous_words.prepend("Four score and ")

#Question 7:
def add_eight(number)
	number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
p eval(how_deep) #gives 42

#Question 8:
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
p flintstones

flintstones.flatten!
p flintstones

#Question 9:
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
p flintstones.assoc("Barney")

#Question 10:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = Hash.new
flintstones.each_with_index { |name, index| flintstones_hash[name] = index }
p flintstones_hash