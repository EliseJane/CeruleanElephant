#Question 1:
if false
  greeting = “hello world”
end

greeting
#nothing will happen because the default for greeting is nil. The variable is
#initialized in the if statement even if the block isn't executed.

#Question 2:
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << 'there'

puts informal_greeting # => "hi there"
puts greetings # => {:a=>'hithere'}
#because informal_greeting is only referencing the original greetings object, so
#the << operator affects the original greetings object to which it references.

#Question 3:
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#one is: one
#two is: two
#three is: three
#because values are being reassigned to new objects that coincidentally have the
#same names. None of this has any effect on the original objects outside the 
#method.

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#one is: one
#two is: two
#three is: three
#because the references inside the method are getting reassigned new values,
#but this still has no effect outside the method.

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#one is: two
#two is: three
#three is: one
#because gsub! permanently mutates the objects being referenced within the method.

#Question 4:
require 'securerandom'

def create_uuid
	uuid_1 = SecureRandom.hex(8)
	uuid_2 = SecureRandom.hex(4)
	uuid_3 = SecureRandom.hex(4)
	uuid_4 = SecureRandom.hex(4)
	uuid_5 = SecureRandom.hex(12)
	puts "#{uuid_1}-#{uuid_2}-#{uuid_3}-#{uuid_4}-#{uuid_5}"
end
create_uuid

#Question 5:
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  true
end
