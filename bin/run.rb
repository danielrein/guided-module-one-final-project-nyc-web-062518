require_relative '../config/environment'
require_relative '../db/yelp_data.rb'
require 'pry'

def greet
    puts 'Welcome to DinnerAndWhatElse..?'
end

def get_user_name
    puts 'Please type in your first name:'
    gets.chomp
end

def save_user_if_new(name)
    if User.find_by name: name
        puts "Welcome back, #{name}!"
    else
        User.create(name: name)
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

def matching_restaurants(zipcode)
    restaurants = search("restaurant", zipcode)
    restaurants_array = restaurants["businesses"].map do |restaurant|
            {
            name: restaurant["name"],
            food_type: restaurant["categories"][0]["title"],
            food_types_display: restaurant["categories"].map { |category| category["title"]}.join(', '),
            rating: restaurant["rating"],
            address: restaurant["location"]["display_address"].join('\n'),
            zipcode: restaurant["location"]["zip_code"]
            }
    end
    restaurants_array
end

def show_matching_restaurants(restaurants_array)
    puts "These are the restaurants in the area:"
    restaurants_array.each do |restaurant|
        puts "Name: #{restaurant[:name]}"
        puts "Food types: #{restaurant[:food_types_display]}"
        puts "Rating: #{restaurant[:rating]}"
        puts "Address: #{restaurant[:address]}"
    end

    # name = restaurants["businesses"][0]["name"]
    # food_type_array = restaurants["businesses"][0]["categories"][0].map { |category| category["title"]}
    # rating = restaurants["businesses"][0]["rating"]
    # address = restaurants["businesses"][0]["location"]["display_address"].join('\n')
end

def selected_event
  puts "Enter selected event name:"
  gets.chomp
end

def selected_restaurant
  puts "Enter selected restaurant name:"
  gets.chomp
end

def create_selected_restaurant(name, restaurants_array)
  if restaurants_array.any? {|r| r[:name].downcase == name.downcase}
    restaurant = restaurants_array.detect { |r| r[:name].downcase == name.downcase }
    Restaurant.create(name: restaurant[:name], location: restaurant[:zipcode], food_type: restaurant[:food_type])
  else
    puts "Invalid choice"
    selected_restaurant
  end
end

def show_user_programs(user)
  puts "Here are the programs of #{user.name}:"
  puts user.programs.name
end

def run
    greet
    name = get_user_name
    save_user_if_new(name)
    current_user = User.find_by name: name
    zipcode = get_zipcode
    date = get_date
    # show_available_event_types(zipcode, date)
    # event_type = get_event_type
    show_matching_events(zipcode, date)
    restaurants_array = matching_restaurants(zipcode)
    show_matching_restaurants(restaurants_array)
    event = selected_event
    restaurant_name = selected_restaurant
    create_selected_restaurant(restaurant_name, restaurants_array)
    
    binding.pry

    Program.create(user_id: current_user.id, event_id: (Event.find_by name: event).id, restaurant_id: Restaurant.last.id)
    show_user_programs(current_user)
end

run
