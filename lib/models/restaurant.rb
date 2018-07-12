old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class Restaurant < ActiveRecord::Base
    has_many :programs
    has_many :events, through: :programs
    has_many :users, through: :programs
end
