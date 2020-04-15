# frozen_string_literal: true

# I hope I understood this task correctly

alphabet = ('a'..'z')
vowels = %w[a e i o u]
hash = {}

alphabet.each_with_index do |letter, index|
  hash[letter] = index if vowels.include? letter
end
