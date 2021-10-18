require 'csv'

module Main

    filename = '/home/devs/Downloads/Wheatherman/Dubai_weather/Dubai_weather_2004_Aug.txt'
    file = File.new(filename, 'r')

    file.each_line("\n") do |row|
      columns = row.split(",")

      break if file.lineno > 10
    end
end
