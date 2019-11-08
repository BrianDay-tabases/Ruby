#!/usr/bin/ruby

#File: login_report_2.rb
#Name: Brian Day
#Course: 383

#pre-reqs
require 'gruff' #included even though this submission addresses everything sans graph generation
require 'csv'
require 'optparse'
require 'open3'

optparser = OptionParser.new
user_login_total = Hash.new(0) #acts as counter
users = Hash.new


ip_opt = w_opt = f_opt = o_opt = c_opt = g_opt = nil #set up with 'off'
c_opt = 'login_report.csv' #default
g_opt = 'login_report.png' #default
# $0 is the name of the program, similar to Bash $0
#optparser.banner = "USAGE: #{$0}" # notice the actual help message
optparser.banner = "USAGE: #{$0}[-i][-w][-f][-o][-c][-g]"
#Account for POSIX --foo  alternatives!!
optparser.on('-i', '--ip') {ip_opt = '-i'}
optparser.on('-w', '--wide') {w_opt = '-w'}
optparser.on('-o', '--out OUTFILE', 'Specific file to output') do |file|
  o_opt = '#{file}'
end
optparser.on('-f', '--file INFILE', 'Specific source file') do |file|
  f_opt = '-f#{file}'
end
optparser.on('-c', '--csv CSVFILE') do |file|
  c_opt = '#{file}'
end
optparser.on('-g', '--graphic PNGFILE') do |file|
  g_opt = '#{file}'
end


begin optparser.parse!
  stdin, stdout, stderr = Open3.popen3("last #{ip_opt} #{w_opt} #{f_opt} #{o_opt} #{c_opt} #{g_opt}")
  line_array = File.readlines
rescue Errno::EACCES => e
  puts "Permission error: #{e.message}"
  exit
rescue Errno::ENOENT => e
  puts "Directory error: #{e.message}"
  exit
rescue Exception => e
  puts "Other error: #{e.message}"
  p "#{ip_opt} #{w_opt}"
  #p line_array
  exit
end

line_array.slice!(-2, 2) #try and remove last two lines from input stream first and foremost (blank line and wtmp lines)
tokens = line_array[-1].split #will split last line as -1 is equal to last entry in an array
#logins per day counter utilize entry date as key
start_date_string = "#{tokens[3]} #{tokens[4]}"
#p start_date_string

line_array.each do |line|
  next if line =~ /^wtmp.*/ || line =~ /^$/ #values to skip (non user data lines)
  tokens = line.split  #tokenize each line
  #p "tokens = #{tokens}"
  user_login_total[tokens[0]] += 1
  if !users.has_key?(tokens[0])
    users[tokens[0]] = []
        pw_line = Open3.popen3("getent passwd #{tokens[0]}").read
        #its possible getent isnt defined if -w wasnt passed   (can hard code -w being passed in if cant get it to work)
        real_name = pw_line.split(':').rstrip.[4].to_sym if pw_line.match
        #push fields into array
        users[tokens[0]] << tokens[4] << tokens[5] << tokens[6]
        #most recent ip addresss
        users[tokens[0]] << tokens[2]
        #p users[tokens[0]]
  else
    #Already exists, toss it out
        if !users[tokens[0]].include?(tokens[2])
          users[tokens[0]] << tokens[2]
        end
  end
end


CSV.open("#{c_opt}", 'w') do |writer|
  writer << ['Username','Fullname','Last Login','Total Logins', 'IP Address List']
  users.each do |k,v|
  #temp_count
  #start_date_string = "#{v[1]} #{v[2]} #{v[3]}"
  puts "#{k},#{v[0]},#{date_string},#{user_login_total[k]},#{v[4]} "
  end
end