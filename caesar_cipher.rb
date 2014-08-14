#original caesar_cipher method from the first Odin Project Ruby assignment

def caesar_cipher (string, num)
  shift = num % 26 
  
  chars = string.split(//)
  chars.map! do |char|
    char_num = char.ord
    was_letter = false
    was_letter = true if (char =~ (/\w/)) #checks if it was originally a letter rather than space or punctuation
  
    #wraparound check. handles capitals and lowercases separately to protect against a large shift causing case confusion
    if (char_num <= 90 && was_letter && (char_num + shift) > 90)
      char_num -= 26
    elsif ((char_num >= 97) && was_letter && (char_num + shift) > 122)
      char_num -= 26
    end
    
    char_num += shift if was_letter
    char = char_num.chr
  end
  
  chars.join
end


print "Enter a phrase to put into secret code: "
phrase = gets.chomp
print "Enter a number that represents the distance you want to shift each letter down the alphabet (HINT--Use negative numbers to decode):"
shift_num = gets.chomp.to_i
puts caesar_cipher(phrase, shift_num)
