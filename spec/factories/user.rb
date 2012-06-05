# require Refinery.roots(:'refinery/authentication').join("app/models/refinery/role.rb")

FactoryGirl.define do
  factory :registrable_user, :class => Refinery::Registrable::User do
    sequence(:username) { |n| "registrable#{n}" }
    sequence(:email) { |n| "registrable#{n}@refinerycms.com" }
    password  "registrable"
    password_confirmation "registrable"
  end
end
