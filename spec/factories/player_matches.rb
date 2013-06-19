# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_match, :class => 'PlayerMatch' do
    player_id 1
    match_id 1
  end
end
