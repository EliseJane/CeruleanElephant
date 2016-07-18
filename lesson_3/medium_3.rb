#Question 3:

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  puts "My string looks like this now: #{a_string_param}"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

#My string looks like this now: pumpkins
	#because the += operator reassigns the conbined string to a new object inside
	#the method, which has no effect on the original string object outside the
	#method.
	
#My array looks like this now: ["pumpkins", "rutabaga"]
	#because the << operator simply adds an element to the same array object, 
	#which is constant throughout the program.

#Question 4:

def tricky_method_two(a_string_param, an_array_param)
  a_string_param.gsub!('pumpkins', 'rutabaga')
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

#My string looks like this now: rutabaga
	#because the gsub! method mutates the original caller permanently, replacing
	#pumpkins with rutabaga.

#My array looks like this now: ["pumpkins"]
	#because the = operator reassigns the variable to a new array object within
	#the method, which has no effect on the orginal array outside the method.

#Question 5:
def color_valid(color)
	color == "blue" || color == "green"
end