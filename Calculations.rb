require 'date'

module Calculations


  def avg_max_temp

    sum= 0
    count = 0
    max_temp.each do |x|
      sum= sum+ x.to_i
      count = count + 1
    end
    avg = sum / count
    avg
  end


  def date_return
    date = dates
    date
  end



  def avg_min_temp
    sum= 0
    count = 0
    min_temp.each do |x|
      sum= sum+ x.to_i
      count = count + 1
    end
    avg = sum/ count
    avg
  end

  def avg_humidity_percentage

    humid_date = Hash[mean_humid.zip(dates)]
    max = -2
    count = 0
    sum = 0
    mean_humid.each do |x|
      if(max < (x.to_i))
        max = x.to_i
      end
      sum= sum + x.to_i
      count = count + 1
    end

    percentage = sum / count

    str = humid_date[max.to_s]
    str1 = str.split("-")
    m = str1[1]
    m = Date::MONTHNAMES[m.to_i]
    [percentage ,m, str1[2]]

  end



  def calculate_max_temp

    temp_date = Hash[max_temp.zip(dates)]
    max = -2
    count = 0
    max_temp.each do |x|
      if(max < (x.to_i))
        max = x.to_i
      end
      count = count + 1
    end

    str = temp_date[max.to_s]
    str1 = str.split("-")
    m = str1[1]
    m = Date::MONTHNAMES[m.to_i]
    [max,m, str1[2]]
  end



  def calculate_min_temp
    temp_date = Hash[min_temp.zip(dates)]

    min = 2000
    count = 0
    min_temp.each do |x|
      if(min > (x.to_i))
        min = x.to_i
      end
      count = count + 1
    end

    str = temp_date[min.to_s]
    str1 = str.split("-")
    m = str1[1]
    m = Date::MONTHNAMES[m.to_i]
    [min,m, str1[2]]
  end


  def ret_high_min_temp
    (max_temp && min_temp).each do |num|
      puts num
    end
  end


