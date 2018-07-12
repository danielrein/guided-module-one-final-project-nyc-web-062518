require_relative '../config/environment'
require_relative '../db/yelp_data.rb'
# require 'pry'

def greet
    puts "\n\n\n"
    puts "                  ***************************************************"
    puts "                  *                                                 *"
    puts "                  *                  Dinner & ...?                  *"
    puts "                  *                                                 *"
    puts "                  ***************************************************"


end

def get_user_name
    sleep(2)
    puts 'Please type in your first name:'
    gets.chomp
end

def save_user_if_new(name)
    if User.find_by name: name
        sleep(1)
        puts "\nWelcome back, #{name}!"
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
    puts "******* AVAILABLE EVENTS: *******\n\n"
    sleep(2)
    matching_events.each { |event| puts "EVENT: #{event.name}\nLOCATION: #{event.zipcode}" }
end

def matching_restaurants(zipcode)
    restaurants = search("restaurant", zipcode)
    restaurants_array = restaurants["businesses"].map do |restaurant|
            {
            name: restaurant["name"],
            food_type: restaurant["categories"][0]["title"],
            food_types_display: restaurant["categories"].map { |category| category["title"]}.join(', '),
            rating: restaurant["rating"],
            address: restaurant["location"]["display_address"].join(' '),
            zipcode: restaurant["location"]["zip_code"]
            }
    end
    restaurants_array
end

def show_matching_restaurants(restaurants_array)
    puts "******* AVAILABLE RESTAURANTS: *******\n\n"
    sleep(2)
    restaurants_array.each do |restaurant|
        puts "NAME: #{restaurant[:name]}"
        puts "FOOD TYPE: #{restaurant[:food_types_display]}"
        puts "RATING: #{restaurant[:rating]}"
        puts "ADDRESS: #{restaurant[:address]}"
        puts ""
        sleep(0.5)
    end

    # name = restaurants["businesses"][0]["name"]
    # food_type_array = restaurants["businesses"][0]["categories"][0].map { |category| category["title"]}
    # rating = restaurants["businesses"][0]["rating"]
    # address = restaurants["businesses"][0]["location"]["display_address"].join('\n')
end

def selected_event
  puts "\n\nEnter selected event name:\n"
  gets.chomp
end

def selected_restaurant
  puts "\n\nEnter selected restaurant name:\n"
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
  puts "\n\n             ************* Here are your selections, #{user.name}: *************\n\n"
  sleep(1)
  user.programs.each do |program|
    puts "\n             Start with dinner at... #{program.restaurant.name}   ...and then enjoy...   #{program.event.name}"
    sleep(1)
  end
end


def run
    greet
    
    puts ''
    name = get_user_name
    save_user_if_new(name)
    current_user = User.find_by name: name
    
    puts ''
    sleep(1)
    zipcode = get_zipcode
    
    puts ''
    date = get_date
    # show_available_event_types(zipcode, date)
    # event_type = get_event_type
    
    puts ''
    restaurants_array = matching_restaurants(zipcode)
    show_matching_restaurants(restaurants_array)

    puts ''
    sleep(3)
    show_matching_events(zipcode, date)
    
    puts ''
    event = selected_event
    restaurant_name = selected_restaurant
    create_selected_restaurant(restaurant_name, restaurants_array)
    Program.create(user_id: current_user.id, event_id: (Event.find_by name: event).id, restaurant_id: Restaurant.last.id)
    sleep(2)
    show_user_programs(current_user)
    puts "\n\n\n"
end

run
