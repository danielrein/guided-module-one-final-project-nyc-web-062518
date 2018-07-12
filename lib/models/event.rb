old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Event < ActiveRecord::Base
    has_many :programs
    has_many :users, through: :programs
    has_many :restaurants, through: :programs
end
