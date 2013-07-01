# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament do
    name { Faker::Name::name }

    # factory :tournament_with_players do
    # 	ignore do
    # 		player_count 8
    # 	end

  		# after(:create) do |tournament, evaluator|
    #     FactoryGirl.create_list(:player, evaluator.player_count, tournaments: tournament)
    #   end
    # end
  end
end
