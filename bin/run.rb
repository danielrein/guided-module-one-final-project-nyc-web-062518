require_relative '../config/environment'
# require 'pry'

def greet
    puts 'Welcome to DinnerAndWhatElse..?'
end

def get_user_name
    puts 'Please type in your name:'
    gets.chomp.downcase
end

def save_user(name)
    User.create(name: name.capitalize)
end

def get_zipcode
    puts 'Please type in a zipcode'
    gets.chomp
end

def get_date
    puts 'Please type in a date in this format: yyyy-mm-dd'
    Date.parse(gets.chomp)
end

def show_available_event_types(zipcode, date)
    puts "These are the event types available in #{zipcode} on #{date}:"
    available_events = Event.where({zipcode: zipcode, date: date})
    available_event_types = available_events.map { |event| event[:event_type] }.uniq
    # available_event_types = Event.all.map { |event| event[:event_type] }.uniq

    available_event_types.each { |type| puts type }
end

def get_event_type
    puts 'Please enter desired event type'
    gets.chomp
end

def show_matching_events(zipcode, date, event_type)
    matching_events = Event.where zipcode: zipcode, date: date, event_type: event_type
    puts "Available events:"
    matching_events.each { |event| puts event.name }
end

def run
    greet
    name = get_user_name
    save_user(name)
    zipcode = get_zipcode
    date = get_date
    show_available_event_types(zipcode, date)
    event_type = get_event_type
    show_matching_events(zipcode, date, event_type)
end

run