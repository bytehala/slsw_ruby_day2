puts 'Enter word:'
word = gets
#word = "#{word.strip}"
word = %r[#{word.strip}]

i = 1
File.open('license.txt', 'r').each_line do |line|
  #if line.include?(word)# != nil && i == 190
  print "#{i} #{line}" if line[word]
  #puts "#{word}"
    #puts 'wa'
  #end

  i = i + 1
end
