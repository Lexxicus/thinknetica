alphabet = ('а'..'я').to_a
alphabet.insert(6, 'ё')
vowels = 'ауоыиэяюёе'
vowels_hash = {}
vowels.each_char do |letter|
  num = alphabet.index(letter) + 1
  vowels_hash[letter] = num
end

print vowels_hash