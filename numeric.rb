require 'csv'
require 'digest/md5'

arr_of_arrs = CSV.parse(ARGF.read.encode('utf-8'), :col_sep => ",", :quote_char => "\"", :encoding => 'UTF-8', :headers => true)

user_h = {}
prob_h = {}

arr_of_arrs.each do |arr|
  puts "#{user_h[arr["user"]] ||= user_h.size+1},#{prob_h[arr["problem"]] ||= prob_h.size+ 1},#{arr["isChallenge"].to_i+1}"
end
