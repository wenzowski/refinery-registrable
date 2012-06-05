FactoryGirl.define do
  factory :user_field, :class => Refinery::Registrable::UserField do
    name 'Profile'
  end
end

FactoryGirl.define do
  factory :user_text_field, :class => Refinery::Registrable::UserField::Text do
    name 'Profile'
  end
end
