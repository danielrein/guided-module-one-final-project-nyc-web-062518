old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Event < ActiveRecord::Base
    has_many :programs
end