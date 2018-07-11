old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Restaurant < ActiveRecord::Base
    has_many :programs
end