require 'rest-client'

require_relative 'data.rb'

def generate_events
    get_data.map do |hash|
        Event.create(name: hash[:name], zipcode: hash[:location], event_type: hash[:genre], date: hash[:localDate])
    end
end

generate_events



# cafe_plaza_deli = Restaurant.create(name: "Cafe Plaza Deli", location: "10004", food_type: "deli")
# broccolino = Restaurant.create(name: "Broccolino", location: "11238", food_type: "italian")
# white_castle = Restaurant.create(name: "White Castle", location: "11373", food_type: "burgers")

# aerosmith = Event.create(name: "Aerosmith", location: "10004", event_type: "music")
# backstreet_boys = Event.create(name: "Backstreet Boys", location: "11238", event_type: "music")
# hamilton = Event.create(name: "Hamilton", location: "11373", event_type: "theater")

# lin = User.create(name: "Maneepailin Sriuthenchai")
# daniel = User.create(name: "Daniel Rein")

