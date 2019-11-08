#File: login_report.rb
#Name: Brian Day
#Course: 383

require 'gruff'
#>> last | head   would be the most recent appended to top of file 
require 'optparse'
optparser = OptionParser.new

# $0 is the name of the program, similar to Bash $0
optparser.banner = "USAGE: #{$0}" # notice the actual help message

optparser.on('-f INFILE', "--file INFILE", "detailed message") do  |file|
  echo "f option passed with #{file} as the required parameter"
end
#optparser.on('-i, IP,) do
#end

#optparser.on('-o OUTFILE', "--file OUTFILE") do
#  echo "o option passed with #{file} as the required outfile"
#end
optparser.on('-l', "--long", "long listing" ) { puts "l option passed"}
begin
  optparser.parse!
rescue => e
  puts e.message
  exit
end
#really below
#optparser.banner line
ip_opt = w_opt = f_opt = nil #set em up
outfile = nil

optparser.on('-i', '--ip') {ip_opt + '-i'}
#then begin - rescue - end

users = {} #OR users = Hash.new
user_login_total = Hash.new(0) #counter

#popen works, but may also use open3
stdout = IO.popen("last #{ip_opt} #{w-opt} #{f_opt}" )

#if open3
#require it
#stdin, stdout, stderr = Open3("last #{ip_opt} #{w-opt} #{f_opt}" )

tokens = line_array[-1].split   #will split last line as -1 is equal to last entry in an array
start_date_string = "#{tokens[3]} #{tokens[4]}"
#p start_date_string

#could remove last two lines from input stream (blank line and wtmp lines)
#line_array.slice!(-2,2)

#p "last #{ip_opt} #{w-opt} #{f_opt}"

line_array.each do |line|
  next if line =~ /^wtmp.*/ || line =~ /^$/  #skip non user data lines
  tokens = line.split  #tokenize each line
  #p "tokens = #{tokens}"
  user_login_total[tokens[0]] += 1
  if !users[tokens[0]] #!users.has_key?(tokens[0])
    #p "populating one-time data...
    users[tokens[0]] = []
	pw_line = IO.popen("getent passwd #{tokens[0]}").read
	#its possible getent isnt defined if -w wasnt passed   (can hard code -w being passed in if cant get it to work)
	real_name = pw_line.split(':')[4] if pw_line
	#push one time fields into array
	users[tokens[0]] << tokens[4] << tokens[5] << tokens[6]
	#most recent ip addresss
	users[tokens[0]] << tokens[2]
	#p users[tokens[0]]
  else
    #p "data exits for #{tokens[0]}: #{users[tokens[0]}"
	if !users[tokens[0]].include?(tokens[2])
	  users[tokens[0]] << tokens[2]
	end
  end	
end  #stdout.readlines


if outfile
  $stdout = File.open(outfile, 'w')
end



#header
puts "UserName,FullName,Last Login, " #finish line
users.each do |k,v|
  date_time = "#{v[1]} #{v[2]} #{v[3]}"
  puts "#{k},#{v[0]},#{date_time},#{user_login_total[k]}, #v   "  #finish after final v








if [[! -z "$x"]];
  then
  #throw out user if already exists

  else
  #append their unique split data into respectable hashes
  
fi



#http responses will come back mostly jumbled, theres another function later that will display page responses in a more appropriate fashion
#openURI is going to be generally the common guy
#can run tests on metadata after a foreach statement printing out an entire webpage
#

def url_report(line_array)
  url_hash = Hash.new
  line_array.each do |line|
    m = line.match(/[A-Z]{3,} *(\/.*)HTTP/) #Somewhat
    url = m[1].rstrip.to_sym if m
    
begin
  line_array = File.readlines(filename)
rescue Errno::EACCES => e
  puts "Permission error: #{e.message}"
  exit
rescue
  Errno::ENOENT => e
  puts "Directory error: #{e.message}"
  exit
rescue Exception => e
  puts "Other error: #{e.message}"
  exit
end

