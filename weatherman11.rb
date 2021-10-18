

require 'date'
require 'csv'
require '/home/devs/Downloads/Weatherman/weatherman/Calculations.rb'

class Weatherman

  include Calculations

  attr_accessor :year, :month, :folder, :data, :max_temp, :max_humidity, :min_temp, :path , :mean_humid, :dates


  def initialize(year = '*' ,  month = '*' ,  folder = '*/*' )

    @path = Dir.glob("#{folder}_#{year}_#{month}.txt")
    @data = []
    @path.each { |n| data << CSV.parse(File.read(n), headers: true)}
    @max_temp = []
    @min_temp = []
    @dates = []
    @max_humidity = []
    @mean_humid = []
    fileSort
  end


  def fileSort
    @data.each do |file|
      @max_temp.concat(file.by_col[1])
      # puts max_temp
      @dates.concat(file.by_col[0])
      @max_humidity.concat(file.by_col[7])
      @min_temp.concat(file.by_col[3])
      @mean_humid.concat(file.by_col[8])
    end

  end

end



def spliter(argv)
  # puts "Spliter"
  year = (argv[1].split('/'))[0]
  folder = argv[2]
  month = ((argv[1].split('/'))[1])
  month = Date::ABBR_MONTHNAMES[month.to_i]
  [year, month]
end


option = ARGV[0]

  case option

    when '-e'
      obj = Weatherman.new(ARGV[1])
      str = obj.calculate_max_temp
      puts "Highest:#{str[0]}C on #{str[1]} #{str[2]} \n"
      str1 = obj.calculate_min_temp
      puts "Lowest:#{str1[0]}C on #{str1[1]} #{str1[2]} \n"
      str2 = obj.avg_humidity_percentage
      puts "Humid:#{str2[0]}% on #{str1[1]} #{str1[2]} \n"

    when '-a'
      split = spliter(ARGV)
      obj1 = Weatherman.new(split[0], split[1])
      puts "Highest Average: #{obj1.avg_max_temp}C  \n"
      puts "Lowest Average: #{obj1.avg_min_temp}C  \n"
      puts "Average Humidity: #{obj1.avg_humidity_percentage}%  \n"

    when '-c'
      puts "Ccase"
      split = spliter(ARGV)
      obj2 = Weatherman.new(split[0], split[1])
      puts "#{split[1]} #{split[0]} \n"

      obj2.ret_high_min_temp.each do |x|
        puts "Bargraph high: #{x}"
        puts "Bargraph Low: #{x.next}"  ###not clear
      end



    else
      puts "Nothing"

  end




