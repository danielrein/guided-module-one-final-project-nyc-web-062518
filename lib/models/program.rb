old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Program < ActiveRecord::Base
    belongs_to :event
    belongs_to :restaurant
    belongs_to :user
end