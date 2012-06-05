module Refinery
  module Registrable
    class UserFieldAttribute < Refinery::Core::BaseModel
      belongs_to :user
      belongs_to :user_field
    end
  end
end
