#!/usr/bin/ruby
#File: home_dir_report.rb
#Name: Brian Day
#Course: 383

###variables###
#directory size (between 20 - 55 inclusive)
dirSize = Random.new
#desired users (least 10, not greater 35)
desiredUsers = 0
#QUOTA named constant, not hard coded. use again in report
QUOTA = 35
#Hash for the username number
userHash = {}
#counter for users greater or equal to QUOTA
count = 0


###retrieve desired quantity, and validate it###
puts "Enter a number between 10 and 35 to represent the number of users:"
desiredUsers = gets.to_i
#originally tried loop based on range as interval. Book only used it as a case/when scenarios
#while [(10..35) === desiredUsers] = FALSE
while desiredUsers > 35 or desiredUsers < 10
  puts "I said between 10 and 35. Try again:"
  desiredUsers = gets.to_i
end


###generate the hash###
1.upto(desiredUsers) do |d|
  userHash["user#{d}".to_sym] = dirSize.rand(20..55).to_s
end


###make header###
puts
puts "User Names and Directory Sizes (* = 1mb)"
puts "========================================="

###make header###
puts
puts "User Names and Directory Sizes (* = 1mb)"
puts "========================================="

###iterating the hash DONT FORGET FOOTER###
userHash.each do |usr, dir|
  puts "#{usr}\t" + ("*" * dir.to_i)
  if dir.to_i > QUOTA
    count += 1
  end
end
puts
puts "#{count} users have directories of at least #{QUOTA}mb"