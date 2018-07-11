require_relative '../config/environment'

def greet
    puts 'Welcome to DinnerAndWhatElse..?'
end

def get_user
    puts 'Please type in your name:'
    gets.chomp.downcase
end

def save_user(name)
    User.create(name: name.capitalize)
end

def get_location
    puts 'Please type in a zipcode'
    gets.chomp
end

def get_date
    puts 'Please type in a date in this format: yyyy-mm-dd'
    Date.parse(gets.chomp)
end
