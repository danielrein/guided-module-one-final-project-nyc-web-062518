require_relative '../config/environment'
require_relative '../db/yelp_data.rb'
# require 'pry'

def greet
    puts 'Welcome to DinnerAndWhatElse..?'
end

def get_user_name
    puts 'Please type in your first name:'
    gets.chomp.downcase
end

def save_user_if_new(name)
    if User.find_by name: name.capitalize
        puts "Welcome back, #{name.capitalize}!"
    else
        User.create(name: name.capitalize)
    end
end

def get_zipcode
    puts 'Please type in a zipcode'
    gets.chomp
end

def get_date
    puts 'Please type in a date in this format: yyyy-mm-dd'
    Date.parse(gets.chomp)
end

# def show_available_event_types(zipcode, date)
#     puts "These are the event types available in #{zipcode} on #{date}:"
#     available_events = Event.where({zipcode: zipcode, date: date})
#     available_event_types = available_events.map { |event| event[:event_type] }.uniq
#     # available_event_types = Event.all.map { |event| event[:event_type] }.uniq

#     available_event_types.each { |type| puts type }
# end

# def get_event_type
#     puts 'Please enter desired event type'
#     gets.chomp
# end

def show_matching_events(zipcode, date)
    matching_events = Event.where zipcode: zipcode, date: date #event_type: event_type
    puts "Available events:"
    matching_events.each { |event| puts "event: #{event.name}, location: #{event.zipcode}" }
end

def show_matching_restaurants(zipcode)
    restaurants = search("restaurant", zipcode)
    restaurants_array = restaurants["businesses"].map do |restaurant|
            {
            name: restaurant["name"],
            food_types: restaurant["categories"].map { |category| category["title"]}.join(', '),
            rating: restaurant["rating"],
            address: restaurant["location"]["display_address"].join('\n')
            }   
    end

    puts "These are the restaurants in the area:"
    restaurants_array.each do |restaurant|
        puts "Name: #{restaurant[:name]}"
        puts "Food types: #{restaurant[:food_types]}"
        puts "Rating: #{restaurant[:rating]}"
        puts "Address: #{restaurant[:address]}"
    end

    # name = restaurants["businesses"][0]["name"]
    # food_type_array = restaurants["businesses"][0]["categories"][0].map { |category| category["title"]}
    # rating = restaurants["businesses"][0]["rating"]
    # address = restaurants["businesses"][0]["location"]["display_address"].join('\n')
end

def run
    greet
    name = get_user_name
    save_user_if_new(name)
    zipcode = get_zipcode
    date = get_date
    # show_available_event_types(zipcode, date)
    # event_type = get_event_type
    show_matching_events(zipcode, date)
    show_matching_restaurants(zipcode)
end

run