require_relative '../config/environment'
require_relative '../db/yelp_data.rb'
require 'pry'

def welcome

    puts "\n\n\n"
    puts "                  ***************************************************"
    puts "                  *                                                 *"
    puts "                  *                  Dinner & ...?                  *"
    puts "                  *                                                 *"
    puts "                  ***************************************************"
    puts "\n\n\n"

end

def get_user_name
    puts 'Please type in your name:'
    gets.chomp
end

def save_user_if_new(name)
    if User.find_by name: name
        puts "\nWelcome back, #{name}!"
    else
        User.create(name: name)
        puts "\nHello, #{name}!"
    end
end

def get_zipcode
    puts 'Type in zipcode:'
    gets.chomp
end

def get_date
    puts 'type in date (yyyy-mm-dd):'
    Date.parse(gets.chomp)
end

def find_matching_events(zipcode, date)
    Event.where zipcode: zipcode, date: date
end

def show_matching_events(matching_events)
    puts "******* AVAILABLE EVENTS: *******\n\n"
    sleep(1)
    matching_events.each { |event| puts "EVENT: #{event.name}\nLOCATION: #{event.zipcode}" }
end

def find_matching_restaurants(zipcode)
    restaurants = search("restaurant", zipcode)
    restaurants["businesses"].map do |restaurant|
            {
            name: restaurant["name"],
            food_type: restaurant["categories"][0]["title"],
            food_types_display: restaurant["categories"].map { |category| category["title"]}.join(', '),
            rating: restaurant["rating"],
            address: restaurant["location"]["display_address"].join(' '),
            zipcode: restaurant["location"]["zip_code"]
            }
    end
end

def show_matching_restaurants(restaurants_array)
    puts "******* AVAILABLE RESTAURANTS: *******\n\n"
    sleep(1)
    restaurants_array.each do |restaurant|
        puts "NAME: #{restaurant[:name]}"
        puts "FOOD TYPE: #{restaurant[:food_types_display]}"
        puts "RATING: #{restaurant[:rating]}"
        puts "ADDRESS: #{restaurant[:address]}"
        puts ""
        sleep(0.5)
    end

end

def get_event_selection
  puts "\n\nEnter selected event name:\n"
  gets.chomp
end

def get_restaurant_selection
  puts "\n\nEnter selected restaurant name:\n"
  gets.chomp
end

def create_selected_restaurant(name, restaurants_array)
    restaurant = restaurants_array.detect { |r| r[:name].downcase == name.downcase }
    if restaurant
        Restaurant.create(name: restaurant[:name], location: restaurant[:zipcode], food_type: restaurant[:food_type])
    else
        puts "Invalid choice"
    end
end

def shuffle_restaurant(restaurants_array)
  restaurants_array.sample
end

def shuffle_event(matching_events)
  matching_events.sample
end

def show_and_confirm_random(user, restaurant, event)
  puts restaurant
  puts event
  input = ""
  while input != "y" && input != "n"
    puts "Keep program?"
    input = gets.chomp.downcase
  end
  if input == "y"
    return true
  else
    return false
  end
end

def save_program(user, restaurant, event)
  Program.create(user_id: user.id, event_id: event.id, restaurant_id: restaurant.id)
end

def show_user_programs(user)
  puts "\n\n             ************* Here are your selections, #{user.name}: *************\n\n"
  sleep(1)
  user.programs.each do |program|
    puts "\n             DINNER AT: #{program.restaurant.name}   AND THEN:  #{program.event.name}"
    sleep(1)
  end
end

def y_or_n?(question)
  input = ""
  while input != "y" && input != "n"
    puts question
    input = gets.chomp.downcase
  end
  if input == "y"
    return true
  else
    return false
  end
end

def run

    # welcome, create/find user, get zipcode, get date
    welcome
    sleep(2)
    name = get_user_name
    sleep(1)
    save_user_if_new(name)
    current_user = User.find_by name: name
    puts ''
    sleep(1)
    zipcode = get_zipcode
    puts ''
    date = get_date

    # find and display matching restaurants and events
    puts ''
    restaurants_array = find_matching_restaurants(zipcode)
    show_matching_restaurants(restaurants_array)
    puts ''
    sleep(3)
    matching_events = find_matching_events(zipcode ,date)
    show_matching_events(matching_events)

    # user's selection: get event/restaurant selection, create program and save to db
    # puts ''
    # event = get_event_selection
    # restaurant_name = get_restaurant_selection
    # create_selected_restaurant(restaurant_name, restaurants_array)
    # Program.create(user_id: current_user.id, event_id: (Event.find_by name: event).id, restaurant_id: Restaurant.last.id)
    # sleep(2)

    # shuffle: randomize event/restaurant selection, create program and save to db
    choice = y_or_n?("Shuffle?")


    while choice == true
      restaurant = shuffle_restaurant(restaurants_array)
      event = shuffle_event(matching_events)
      x = show_and_confirm_random(current_user, restaurant, event)
      if x
        restaurant_new = Restaurant.create(name: restaurant[:name], location: restaurant[:zipcode], food_type: restaurant[:food_type])
        save_program(current_user, restaurant_new, event)
        puts "Saved!"
      end
      choice = y_or_n?("Shuffle again?")
    end

    # display user's programs
    show_user_programs(current_user)
    puts "\n\n\n"
end

run
