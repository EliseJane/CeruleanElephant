#Question 1:
statement = "The Flintstones Rock!"
10.times { |i| puts (' ' * i) + statement }

#Question 2:
statement = "The Flintstones Rock"
lettercount = Hash.new

statement.each_char do |char|
	if lettercount.has_key?(char) == false
		value = statement.count(char)
		lettercount.merge!(char=>value)
	end
end

p lettercount

#Question 3:

#You cannot add a fixnum to a string.

puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

#Question 4:
numbers = [1, 2, 3, 4]
numbers.each do |number|
	p number
	numbers.shift(1)
end
#prints every other element of the array because it prints one, then deletes one
#from the beginning, then prints one, then deletes one from the beginning.

numbers = [1, 2, 3, 4]
numbers.each do |number|
	p number
	numbers.pop(1)
end
#prints the first two elements because it prints one, then deletes one from the 
#end, then prints one, then deletes one from the end.

#Question 5:
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
  	dividend -= 1
  end
  p divisors
end

#Bonus 1: that is the part of the expression that identifies a factor. If there
#is a remainder of zero when dividing by that number then it is a factor.

#Bonus 2: returns (or prints) the completed array after iteration is complete.

#Question 6
#An additional difference is that in the first example 'buffer' is an argument
#in the original method so it will be modified by the method. In the second 
#example the variable buffer is initialized inside the method so the original 
#input_array argument will not be modified.

#Question 7:
#Ben tries to call on the 'limit' variable which is outside the scope of the 
#method. Instead including 'limit' as an argument in the method fixes this, as
#well as making the method more flexible, as the limit can be changed.

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

#Question 8:
def titleize!(string)
	words = string.scan(/\w+/)
	title = String.new
	words.each {|word| title << (word.capitalize! + " ")}
	title.strip!
end
#or
def yourway(string)
	title = string.split.map! {|word| word.capitalize!}.join(' ')
	title
end
p titleize!("is this going to work")
p yourway("is this also going to work")

#Question 9:
p munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each_value do |stats|
	case stats["age"]
	when 0..17
		stats.merge!("age_group" => "kid")
	when 18..64
		stats.merge!("age_group" => "adult")
	when 65..1000
		stats.merge!("age_group" => "senior")
	end
end
p munsters