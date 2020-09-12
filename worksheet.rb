driver_trips = [
  {DR0001: [{"3rd Feb 2016": [{cost: 10, rider_id: "RD0003", rating: 3},
                              {cost: 30, rider_id: "RD0015", rating: 4}]},
            {"5th Feb 2016": [{cost: 45, rider_id: "RD0003", rating: 2}]}]},
  {DR0002: [{"3rd Feb 2016": [{cost: 25, rider_id: "RD0073", rating: 5}]},
            {"4th Feb 2016": [{cost: 15, rider_id: "RD0013", rating: 1}]},
            {"5th Feb 2016": [{cost: 35, rider_id: "RD0066", rating: 3}]}]},
  {DR0003: [{"4th Feb 2016": [{cost: 5, rider_id: "RD0066", rating: 5}]},
            {"5th Feb 2016": [{cost: 50, rider_id: "RD0003", rating: 2}]}]},
  {DR0004: [{"3rd Feb 2016": [{cost: 5, rider_id: "RD0022", rating: 5}]},
            {"4th Feb 2016": [{cost: 10, rider_id: "RD0022", rating: 4}]},
            {"5th Feb 2016": [{cost: 20, rider_id: "RD0073", rating: 5}]}]}
]

def average_rating(array)
  rating_hash = {}
  array.each do |driver_hash|
    rating_array = []
    driver_hash.each do |driver, date_array|
      date_array.each do |date_hash|
        date_hash.each do |_date, ride_array|
          ride_array.each do |ride_data|
            rating_array.push(ride_data[:rating])
          end
        end
      end
      rating_hash[driver] = (rating_array.sum / rating_array.length.to_f).round(1)
    end
  end
  return rating_hash
end

def nice_average(hash)
  string = ""
  hash.each do |key, value|
    string += "\nDriver #{key}: #{value} rating"
  end
  return "Average ratings:" + string + "\n\n"
end

def total_rides(array)
  ride_hash = {}
  array.each do |driver_array|
    rides = 0
    driver_array.each do |driver, ride_array|
      ride_array.each do |date_hash|
        date_hash.each do |_date, ride_array|
          rides += ride_array.count
        end
      end
      ride_hash[driver] = rides
    end
  end
  return ride_hash
end

def nice_rides(hash)
  string = ""
  hash.each do |key, value|
    string += "\nDriver #{key}: #{value} rides"
  end
  return "Total Rides:" + string + "\n\n"
end

def total_earnings(array)
  driver_earnings = {}
  array.each do |driver_hash|
    earnings = 0
    driver_hash.each do |driver, date_array|
      date_array.each do |date_hash|
        date_hash.each do |date, ride_array|
          ride_array.each do |ride_data|
            earnings += ride_data[:cost]
          end
        end
      end
      driver_earnings[driver] = earnings
    end
  end
  return driver_earnings
end

def nice_earnings(hash)
  string = ""
  hash.each do |key, value|
    string += "\nDriver #{key}: $#{sprintf("%.2f", value)}"
  end
  return "Total earnings:" + string + "\n\n"
end

def max_driver(hash)
  return hash.max_by { |_driver, value| value }
end

def superlative_earner(array)
  return "Driver #{array[0]} earned the most with $#{sprintf("%.2f", array[1])} in earnings.\n\n"
end
def superlative_driver(array)
  return "Driver #{array[0]} has the highest average rating of #{sprintf("%.1f", array[1])}.\n"
end

def days_by_driver(array)
  earn_by_day = []
  array.each do |driver_hash|
    another_temp_hash = {}
    driver_hash.each do |driver, date_array|
      temp_hash = {}
      date_array.each do |date_hash|
        earnings = 0
        date_hash.each do |date, ride_array|
          ride_array.each do |ride_data|
            earnings += ride_data[:cost]
          end
          temp_hash[date] = earnings
        end
      end
      another_temp_hash[driver] = temp_hash
      earn_by_day.push(another_temp_hash)
    end
  end
  return earn_by_day
end

def best_day(array)
  best_day = {}
  array.each do |driver_hash|
    driver_hash.each do |driver, date_array|
      best_day[driver] = date_array.max_by { |key, value| value }
    end
  end
  return best_day
end

def nice_best_day(hash)
  string = ""
  hash.each do |key, value|
    string += "\nDriver #{key}'s best day was #{value[0]}, when they earned $#{value[1]}"
  end
  return "\nEach Driver's Best Day:" + string + "\n"
end

puts "\nBelow is ride information for drivers DR0001 - DR0004"
puts "for trips performed from Feb 3, 2016 through Feb 5, 2016\n\n"

puts nice_rides(total_rides(driver_trips))
puts nice_earnings(total_earnings(driver_trips))
puts nice_average(average_rating(driver_trips))
puts superlative_earner(max_driver(total_earnings(driver_trips)))
puts superlative_driver(max_driver(average_rating(driver_trips)))
puts nice_best_day(best_day(days_by_driver(driver_trips)))
