# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts (answer)

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
puts MESSAGES.inspect

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def operation_to_message(op)
  selection = case op
              when '1'
                'Adding'
              when '2'
                'Subtracting'
              when '3'
                'Multiplying'
              when '4'
                'Dividing'
              end
  selection
end

prompt MESSAGES['welcome']

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

loop do
  number1 = ''
  loop do
    prompt MESSAGES['first_number']
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt MESSAGES['number_error']
    end
  end

  number2 = ''
  loop do
    prompt MESSAGES['second_number']
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt MESSAGES['number_error']
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt MESSAGES['operation_error']
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result = case operator
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             number1.to_f / number2.to_f
           end

  prompt "The result is #{result}!"

  prompt MESSAGES['again']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt MESSAGES['farewell']