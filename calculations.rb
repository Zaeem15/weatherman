# frozen_string_literal: true

require 'date'

# Module to Calculate
module Calculations
  def return_sum(arr)
    arr.map(&:to_i).inject(:+)
  end

  def return_month_year(hash, index)
    str = hash[index.to_s]
    str1 = str.split('-')
    month = str1[1]
    month = Date::MONTHNAMES[month.to_i]
    [month, str1[2]]
  end

  def avg_max_temp
    sum = return_sum(max_temp)
    sum / max_temp.size
  end

  def avg_min_temp
    sum = return_sum(min_temp)
    sum / min_temp.size
  end

  def avg_humidity_percentage
    humid_date = Hash[mean_humid.zip(dates)]
    max = -2
    mean_humid.each do |x|
      max = x.to_i if max < (x.to_i)
    end
    sum = return_sum(mean_humid)
    percentage = sum / mean_humid.size
    year, month = return_month_year(humid_date, max)
    [percentage, month, year]
  end

  def calculate_max_temp
    max_temp_date = Hash[max_temp.zip(dates)]
    max = -2
    max_temp.each do |x|
      max = x.to_i if max < (x.to_i)
    end
    year, month = return_month_year(max_temp_date, max)
    [max, month, year]
  end

  def calculate_min_temp
    min_temp_date = Hash[min_temp.zip(dates)]
    min = 2000
    min_temp.each do |x|
      min = x.to_i if min > (x.to_i)
    end
    year, month = return_month_year(min_temp_date, min)
    [min, month, year]
  end
end
