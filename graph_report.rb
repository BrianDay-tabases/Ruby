#!/usr/bin/ruby
#File: graph_report.rb
#Name: Brian Day
#Course: 383

require 'csv' #even though this submission is based on hard-coded entries
require 'gruff'

#rows = Array.new
#CSV.foreach('login_report.csv', converters::numeric) do |reader|
#  rows << reader.values_at(2,4) #take the date and total
  #append the retrieved values to an array for g.data to use
#end


g = Gruff::Line.new()
g.title = "wtmp begins Sat Apr 1 10:38:23 2017"
g.labels = {0=>'Logins'}
g.x_axis_label = "Date"
g.y_axix_label = "Number of Logins"
{"Apr 1"=>22,
 "Apr 2"=>18,
 "Apr 3"=>10,
 "Apr 4"=>33,
 "Apr 5"=>33,
 "Apr 6"=>65,
 "Apr 7"=>18,
 "Apr 8"=>10,
 "Apr 9"=>18,
 "Apr 10"=>46,
 "Apr 11"=>35,
 "Apr 12"=>63,
 "Apr 13"=>103,
 "Apr 14"=>34,
 "Apr 15"=>9,
 "Apr 16"=>7,
 "Apr 17"=>5}.each do |date, logins|
  g.data(date, logins )
end
g.write("login_report.png")