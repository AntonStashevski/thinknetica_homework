# frozen_string_literal: true

def chomp_information
  info_hash = {}
  puts 'Enter the name price and count in the format (name price count).
to exit write stop'
  loop do
    name, price, count = gets.chomp.split(' ')
    if name == 'stop'
      puts "Result hash: #{info_hash}"
      return info_hash
    else
      info_hash.merge!(name => { price: price, count: count })
    end
  end
end

def sum_calculator(information)
  full_price = 0
  information.map do |product|
    price_count_arr = product.last.values.map(&:to_i)
    total_price = price_count_arr.first * price_count_arr.last
    full_price += total_price
    puts "For product: #{product.first} total price: #{total_price}"
  end
  puts "Total price: #{full_price}"
end

information = chomp_information
sum_calculator(information)
