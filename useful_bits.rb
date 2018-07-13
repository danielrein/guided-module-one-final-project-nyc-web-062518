require 'rest-client'
require 'JSON'
require 'pry'

ticketmaster_data = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey=Jx5LTUJQVff8r3cmh2vUuABLGHjW8Nar')

JSON.parse(ticketmaster_data).keys
=> ["_embedded", "_links", "page"]

JSON.parse(ticketmaster_data)["_embedded"]
=> {"events"=>
  [{"name"=>"JAY-Z and BEYONCÉ - OTR II",
    "type"=>"event",
    "id"=>"vvG1iZ4kyNVsor",
    "test"=>false,
    "url"=>
     "https://www.ticketmaster.com/jayz-and-beyonce-otr-ii-pasadena-california-0
9-23-2018/event/0B00546E63D3145E",
    "locale"=>"en-us",
    "images"=>
     [{"ratio"=>"3_2",
       "url"=>
        "https://s1.ticketm.net/dam/a/8dc/90d0489c-30b7-4068-9b12-ac20afb3f8dc_655581_RETINA_PORTRAIT_3_2.jpg",
       "width"=>640,
       "height"=>427,
       "fallback"=>false},
      {"ratio"=>"4_3",
       "url"=>
        "https://s1.ticketm.net/dam/a/8dc/90d0489c-30b7-4068-9b12-ac20afb3f8dc_655581_CUSTOM.jpg",}

JSON.parse(ticketmaster_data)["_links"]
=> {"first"=>{"href"=>"/discovery/v2/events.json?page=0&size=20"},
 "self"=>{"href"=>"/discovery/v2/events.json"},
 "next"=>{"href"=>"/discovery/v2/events.json?page=1&size=20"},
 "last"=>{"href"=>"/discovery/v2/events.json?page=8150&size=20"}}

 JSON.parse(ticketmaster_data)["page"]
 =>{"size"=>20, "totalElements"=>163010, "totalPages"=>8151, "number"=>0}

binding.pry
false


##############################

Event.event_type =
parsed_data["_embedded"]["events"].map do |event|
  event["classifications"][0]["genre"]["name"]
end

Event.name =
parsed_data["_embedded"]["events"].map do |event|
  event["name"]
end

Event.location =
parsed_data["_embedded"]["events"].map do |event|
  event["_embedded"]["venues"][0]["postalCode"]
end

Event.date =
parsed_data["_embedded"]["events"].map do |event|
  event["dates"]["start"]["localDate"]
end

Event.time =
parsed_data["_embedded"]["events"].map do |event|
  event["dates"]["start"]["localTime"]
end

Event.dateTime =
parsed_data["_embedded"]["events"].map do |event|
  event["dates"]["start"]["dateTime"]
end


JSON.parse(ticketmaster_data)["_embedded"]["events"].map do |event|
    puts event["name"]  
    puts event["_embedded"]["venues"][0]["postalCode"] 
    puts event["classifications"][0]["genre"]["name"] 
    puts event["dates"]["start"]["dateTime"] 
    end



    ## UNUSED CODE FROM run.rb


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



    # name = restaurants["businesses"][0]["name"]
    # food_type_array = restaurants["businesses"][0]["categories"][0].map { |category| category["title"]}
    # rating = restaurants["businesses"][0]["rating"]
    # address = restaurants["businesses"][0]["location"]["display_address"].join('\n')