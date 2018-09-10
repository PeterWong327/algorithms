require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  #not palindrome if there is more than 1 char that has a count of 1
  new_hash = HashMap.new

  #iterate through string at each char
  string.chars.each do |char|
    # +1 if char is in hash
    if new_hash.include?(char)
      new_hash.delete(char)
    else
      #set val to 1 if char is not in hash
      new_hash.set(char, 1)
    end
  end

  #look at the counts of all chars and check if even/odd num of chars
  if string.length % 2 == 0 && new_hash.count == 0
    return true
  elsif string.length % 2 != 0 && new_hash.count == 1
    return true
  else
    return false
  end
  # return new_hash.values.count(1) <= 1
end
