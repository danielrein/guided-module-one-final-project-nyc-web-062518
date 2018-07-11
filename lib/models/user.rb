old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class User < ActiveRecord::Base
    has_many :programs
    has_many :events, through: :programs
    has_many :restaurants, through: :programs
end