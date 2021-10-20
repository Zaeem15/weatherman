# frozen_string_literal: true

require 'date'
require 'csv'
require 'colorize'
require '/home/devs/Downloads/Weatherman/weatherman/calculations'

# Main class of Weatherman
class Weatherman
  include Calculations

  attr_accessor :year, :month, :folder, :data, :max_temp, :max_humidity, :min_temp, :path, :mean_humid, :dates

  def initialize(year = '*', month = '*', folder = '*/*')
    @path = Dir.glob("#{folder}_#{year}_#{month}.txt")
    initialize_arrays
    @path.each do |n|
      data << CSV.parse(File.read(n), headers: true)
      populate_arrays
      break if ARGV[0] == '-c'
    end
  end

  def initialize_arrays
    @data = []
    @max_temp = []
    @min_temp = []
    @dates = []
    @max_humidity = []
    @mean_humid = []
  end

  def populate_arrays
    @data.each do |file|
      @max_temp.concat(file.by_col[1])
      @dates.concat(file.by_col[0])
      @max_humidity.concat(file.by_col[7])
      @min_temp.concat(file.by_col[3])
      @mean_humid.concat(file.by_col[8])
    end
  end
end

def ret_month_year(argv)
  year = (argv[1].split('/'))[0]
  month = ((argv[1].split('/'))[1])
  month = Date::ABBR_MONTHNAMES[month.to_i]
  [year, month]
end

year, month = ret_month_year(ARGV)
option = ARGV[0]

case option

when '-e'
  obj = Weatherman.new(ARGV[1])
  max, month, year = obj.calculate_max_temp
  puts "Highest:#{max}C on #{month} #{year} \n"
  min, month, year = obj.calculate_min_temp
  puts "Lowest:#{min}C on #{month} #{year} \n"
  percentage, month, year = obj.avg_humidity_percentage
  puts "Humid:#{percentage}% on #{month} #{year} \n"

when '-a'
  obj1 = Weatherman.new(year, month)
  puts "Highest Average: #{obj1.avg_max_temp}C  \n"
  puts "Lowest Average: #{obj1.avg_min_temp}C  \n"
  puts "Average Humidity: #{obj1.avg_humidity_percentage[0]}%  \n"

when '-c'
  obj2 = Weatherman.new(year, month)
  puts "#{month} #{year} \n"

  min_max_temp = obj2.min_temp.zip(obj2.max_temp)

  min_max_temp.each_with_index do |(min_tem, max_tem), i|
    next if min_tem.nil? && max_tem.nil?

    puts "#{i + 1} #{'+'.red * min_tem.to_i} #{min_tem}C"
    puts "#{i + 1} #{'+'.blue * max_tem.to_i} #{max_tem}C"
  end

  puts "\n#{month} #{year} \n"

  min_max_temp.each_with_index do |(min_tem, max_tem), y|
    next if min_tem.nil? && max_tem.nil?

    puts "#{y + 1} #{'+'.blue * max_tem.to_i}#{'+'.red * min_tem.to_i} #{max_tem}C - #{min_tem}C"
  end

else
  puts 'Wrong Case'

end
