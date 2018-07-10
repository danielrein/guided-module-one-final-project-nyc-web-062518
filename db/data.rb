require 'rest-client'
require 'JSON'
require 'pry'

ticketmaster_data = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page1 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=1&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page2 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=2&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page3 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=3&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page4 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=4&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page5 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=5&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page6 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=6&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')
ticketmaster_data_page7 = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?page=7&size=20&apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')

parsed_data = JSON.parse(ticketmaster_data_page2)

events_array = parsed_data["_embedded"]["events"].map do |event|
        {
        name: event["name"],
        location: event["_embedded"]["venues"][0]["postalCode"],
        genre: event["classifications"][0]["genre"]["name"],
        dateTime: event["dates"]["start"]["dateTime"] 
                }
    end

    binding.pry
    false