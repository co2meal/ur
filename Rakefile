# coding: utf-8
require 'rubygems'
require 'json'
require 'csv'
require 'digest/md5'
require 'rake/clean'

data_files = Rake::FileList.new("data/*")
task :default => :numeric
task :numeric => ['numeric.csv', 'user_h.csv', 'prob_h.csv']
task :clean do
  rm ['numeric.csv', 'user_h.csv', 'prob_h.csv']
end


@user_h = {}
@prob_h = {}

def numeric(src)
  res = []
  arr_of_arrs = nil
  File.open(src,"r") do |f|
    arr_of_arrs = CSV.parse(f.read.encode('utf-8'), :col_sep => ",", :quote_char => "\"", :encoding => 'UTF-8', :headers => true)
    arr_of_arrs.each do |arr|
      @user_h[arr["user"]] ||= {id: @user_h.size+1, info: arr}
      @prob_h[arr["problem"]] ||= {id: @prob_h.size+1, info: arr}
      res << CSV.generate_line([
        @user_h[arr["user"]][:id],
        @prob_h[arr["problem"]][:id],
        arr["isChallenge"].to_i+1
      ])
    end
  end
  return res
end

file 'numeric.csv' => data_files do |t|
  res = []
  t.prerequisites.each do |src|
    puts 'Reading %s' % src
    res << numeric(src)
  end
  File.open(t.name, "wb") do |f|
    f.write res.reject(&:empty?).join("\n")
  end
end

file 'user_h.csv' => 'numeric.csv' do |t|
  puts 'Writing %s(%d)' % [t.name, @user_h.size]
  File.open(t.name, "wb") do |f|
    f.write @user_h.map{|k,v| CSV.generate_line [k,v[:id],v[:info]]}.join
  end
end

file 'prob_h.csv' => 'numeric.csv' do |t|
  puts 'Writing %s(%d)' % [t.name, @prob_h.size]
  File.open(t.name, "wb") do |f|
    f.write @prob_h.map{|k,v| CSV.generate_line [k,v[:id],v[:info]]}.join
  end
end
