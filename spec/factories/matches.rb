# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do


  factory :match do | m |
	 	# m.players { FactoryGirl.create(:player) }
  	#player2 { Factory(:player) }
  	#player {[FactoryGirl.create(:player)]}
  	
  	
    tournament_id 1
  end
end
