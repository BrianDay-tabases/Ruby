#!/usr/bin/ruby
#File: apache_report.rb
#Name: Brian Day
#Course: 383

#Header first, because same regardless/independent of file
puts "----------------------------------------------------"
puts "Statistics for the Apache log file access_log"
puts "----------------------------------------------------"
puts

#Counting Hashes for total IPs, URLs, and HTTP status codes AS SYMBOLS
#Values will be populate from do...end
ipHash = Hash.new(0)   # = {}
urlHash = Hash.new(0)  # = {}
httpHash = Hash.new(0) # = {}
lineArray = []
tokenArray = []



#open and 'r' approach FAULTY
#File.open("access_log", "r").each_line do |line|

#readlines approach
lineArray = File.readlines("access_log")
PERCENTDENOM  = lineArray.size
lineArray.each do |line|
  tokens = line.split
  tokenArray.push(tokens)
  ipHash[tokens[0]] += 1
  urlHash[tokens[6]] += 1
  httpHash[tokens[8]] += 1
end


#First sub report IP histogram, 20 spaces
puts "Frequency of Client IP ADdresses:"
ipHash.each do |ip, v|
  printf("%-20s", ip)
  puts("*" * v.to_i)
end


puts
#Second sub report unique URLS, printf with 45 to fit everything
puts "Frequency of URLs Accessed:"
urlHash.each do |url, v|
  printf("%-45s", url)
  puts v
end


puts
#Third sub report HTTP status codes sorted by code, and percentage based on size
puts "HTTP Status Codes Summary:"
httpHash.each.sort_by do |http, v|
  v = v.to_f * 100.0
  v = (v / PERCENTDENOM).round
  puts "#{http}" + ": " + "#{v}"  + "%"
end