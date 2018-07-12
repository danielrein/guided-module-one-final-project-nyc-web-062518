old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

class User < ActiveRecord::Base
    # WTF!!!!!!???????
    # has_many :programs
    has_many :events, through: :programs
    has_many :restaurants, through: :programs

    def programs
      Program.all.select { |program| program.user_id == self.id }
    end
end
