#!/usr/bin/ruby

#File: create_user_records.rb
#Name: Brian Day
#Class: CIT383-Spring


users = []
record = []

empID = ""
empFirst = ""
empLast = ""
fullName = ""



#I originally had prints in lieu of puts to have response on same line as prompt, but ruby interpreter error every time
input = gets.chomp
while input == ('Y' || 'yes')
  puts "Enter the user's employee id:  "
  empID = gets.chomp
  record.push(empID)
  puts "Enter the user's first name:  "
  empFirst = gets.chomp
  puts "Enter the user's last name:  "
  empLast = gets.chomp
  fullName = empFirst.join(empLast)
  record.push(fullName)
  users.push(record)
  puts "Would you like to create another record(type yes or Y to continue): "
  input = gets.chomp
end

#now that loop is done, display results
puts "Summary"
puts "============================="
puts "#{users.length} records created"



#first array pair based on displayCounter, second number is static and based on the value for that record
displayCounter = users.length
while displayCounter > 0
  puts "Name: "<< String(users[displayCounter][1])
  puts "Employee Id: "<< String(users[displayCounter][0])
  puts
  displayCounter +=
end