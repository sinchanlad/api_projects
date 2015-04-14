require 'open-uri'
require 'json'

# If you experience an error relating to SSL,
#   uncomment the following two lines:

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
street_address = gets.chomp
url_safe_street_address = URI.encode(street_address)

# Your code goes below.

url_of_data_we_want1 = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&sensor=false"
raw_data1 = open(url_of_data_we_want1).read
parsed_data1 = JSON.parse(raw_data1)
geo_location = parsed_data1["results"][0]["geometry"]["location"]
the_latitude = geo_location["lat"]
the_longitude = geo_location["lng"]

url_of_data_we_want2 = "https://api.forecast.io/forecast/c08001da7d19096c0879a5ba1d349e53/"+the_latitude.to_s+","+the_longitude.to_s
raw_data2 = open(url_of_data_we_want2).read
parsed_data2 = JSON.parse(raw_data2)
the_temperature = parsed_data2["currently"]["temperature"]
the_hour_outlook = parsed_data2["hourly"]["data"][1]["summary"]
the_day_outlook = parsed_data2["daily"]["data"][1]["summary"]

# Ultimately, we want the following line to work when uncommented:

puts "The current temperature at #{street_address} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"
