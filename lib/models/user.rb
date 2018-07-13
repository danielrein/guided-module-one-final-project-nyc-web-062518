old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class User < ActiveRecord::Base
    # the line "has_many :programs" is commented out because it didn't function as expected. Cause to be identified..
    # A "programs" method is defined below as a substitute.
  
    # has_many :programs
    has_many :events, through: :programs
    has_many :restaurants, through: :programs

    def programs
      Program.all.select { |program| program.user_id == self.id }
    end
end
