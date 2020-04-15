# frozen_string_literal: true

def fib(num)
  first_num = 0
  second_num = 1
  (num - 1).times do
    first_num, second_num = second_num, first_num + second_num
  end
  first_num
end

array = []
number = 0
loop do
  fib_number = fib(number)
  break if fib_number > 100

  array << fib_number
  number += 1
end

puts "Fibonacci array : #{array.uniq!}"
