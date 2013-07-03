# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
	 	# players { FactoryGirl.create(:player) }
    tournament_id 1
  end
end
