#!/usr/bin/ruby
#File: apache_report_2.rb
#Name: Brian Day
#Course: 383

lineArray = []
#empty until we do readlines method

#Tried this until found out Ruby needs method definition before calling it
#f = File.open("access_log", "r")
#begin
#       puts
#       ip_report()
#       puts
#       url_report()
#       puts
#       http_report()
#       f.close
#rescue SystemCallError #Errno::ENOENT
#       print "File or directory not found. Sorry!"
#rescue SystemCallError #Errno::EPERM
#       print "Operation not permitted. Cannot access file unless you have permission. Sorry!"
#ensure
#       f.close
#end

#Exception Handling
begin
  f = File.open("access_log", "r")
rescue SystemCallError #Errno::ENOENT   Treat different than permissions issue
  print "File or directory not found. Sorry!"
rescue SystemCallError #Errno::EPERM    Treat different than no dir/file issue
  print "Operation not permitted. Cannot access file unless you have permission. Sorry!"
end

lineArray = f.readlines
PERCENTDENOM  = lineArray.size
lineArray.each do |line|
#  ipHash[Regexp[1].to_sym] += 1
#  urlHash[Regexp[2].to_sym] += 1
#  httpHash[Regexp[3].to_sym] += 1
#end

#TRY NOT TO DO AS GLOBAL...
$Regexp.new = /\A(?<ip>\S+) \S+ \S+ "(?<packetmethod>GET|POST|OPTION) (?<url>\S+) \S+?" (?<code>\d+)/
$chunks = Regex.match(lineArray)
$chunks[:ip], chunks[:url], chunks[:code], chunks[:packetmethod]
end

def ip_report(lineArray)
  ipHash = Hash.new {|ip, v| ip[v]=0}
  ipHash.each do |ip, v|
    printf("%-20s", ip)
    puts("*" * v.to_i)
  end
end

def url_report(lineArray)
  urlHash = Hash.new {|url, v| url[v]=0}
  urlHash.each do |url, v|
    print url.to_s.ljust(50)
    puts v
  end
end

def http_report(lineArray)
  httpHash = Hash.new {|http, v| http[v]=0}
  httpHash.each.sort_by do |http, v|
    v = v.to_f * 100.0
    v = (v / PERCENTDENOM).round
    puts "#{http}" + ": " + "#{v}"  + "%"
  end
end

#Header
puts "----------------------------------------------------"
puts "Statistics for the Apache log file access_log"
puts "----------------------------------------------------"
puts

#SubReports called
puts "Frequency of Client IP ADdresses:"
ip_report(lineArray)
puts "Frequency of URLs Accessed:"
url_report(lineArray)
puts "HTTP Status Codes Summary:"
http_report(lineArray)