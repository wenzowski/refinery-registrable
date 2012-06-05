module Refinery
  module Registrable
    class UserFieldValidation < Refinery::Core::BaseModel
      belongs_to :user_field
    end
  end
end
