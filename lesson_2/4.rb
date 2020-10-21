alphabet = ('а'..'я').to_a
alphabet.insert(6, 'ё')
glasnie = 'ауоыиэяюёе'
glasnie_hash = {}
glasnie.each_char do |letter|
  num = alphabet.index(letter) + 1
  glasnie_hash[letter] = num
end

print glasnie_hash