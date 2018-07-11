require 'rest-client'
require 'JSON'
require 'pry'

def get_data
  array_of_arrays = []
  uri = "https://app.ticketmaster.com/discovery/v2/events.json?page=0&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar"
  5.times do
    parsed_data = JSON.parse(RestClient.get(uri))
    current_page = events_array(parsed_data)
    array_of_arrays << current_page
    uri = "https://app.ticketmaster.com" + parsed_data["_links"]["next"]["href"] + "&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar"
    sleep(1)
  end
  array_of_arrays.flatten[0]
end

def events_array(parsed_data)
  parsed_data["_embedded"]["events"].map do |event|
        {
        name: event["name"],
        location: event["_embedded"]["venues"][0]["postalCode"],
        genre: event["classifications"][0]["genre"]["name"],
        dateTime: event["dates"]["start"]["dateTime"]
                }
    end
end

    binding.pry
    false
