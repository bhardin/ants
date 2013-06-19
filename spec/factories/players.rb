# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :player do
    name { Faker::Name::name }
    match_id 1
  end
end
