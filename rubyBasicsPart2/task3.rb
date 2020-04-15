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
(0..100).map do |number|
  break if fib(number) > 100

  array << fib(number)
end

puts "Fibonacci array : #{array.uniq!}"
