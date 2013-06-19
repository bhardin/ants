require 'spec_helper'

describe PlayerMatch do
	let(:player_match) { FactoryGirl.create :player_match }

  it "has players" do
  	player_match.should respond_to(:player)
  end

  it "has a match_id" do
  	player_match.should respond_to(:match)
  end

  it "belongs to a tournament" do
  	player_match.should respond_to(:tournament)
	end

	it "has a score for the first game" do
		player_match.should respond_to(:first_game_score)		
	end

	it "has a score for the second_game" do
		player_match.should respond_to(:second_game_score)		
	end

	describe "scores" do
		for game in ["first_game", "second_game"]
			context "for #{game}" do
				it "can't be more than 10 points" do
					pending
					(player_match.first_game_score = 11).should be_false
				end
				
				for score in 0..10 do
					it "can be #{score}" do
						pending
						(player_match.first_game_score = score.to_i).should be_true
					end
				end
			end
		end
	end

end
