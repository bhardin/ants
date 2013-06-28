require 'spec_helper'

describe Tournament do
	let(:tournament) { FactoryGirl.create :tournament }

	it { tournament.should respond_to(:matches) }
	it { tournament.should respond_to(:players) } 	

	describe "#start_tournament" do
		it "changes status to Running" do
			# lambda { tournament.start_tournament }.should change(:status).to("Running")
		end

		it "seeds the first round" do
			# lambda { tournament.start_tournament }.should call(:seed_round)
		end

		it "saves itself"
	end

	describe "#current_round" do
		it "returns the round number" do
			tournament.stub(:round).and_return(5)
			tournament.current_round.should be(5)
		end
	end

	describe "#end_tournament" do
		it "sets the status as Finished"

		it "saves itself"
	end

	describe "#can_add_players?" do
		context "when tournament is running" do
			it "returns false" do
				tournament.stub(:running?).and_return(true)
				tournament.can_add_players?.should be_false
			end
		end
	end

	describe "#next_round" do
		context "when it's the last_round" do
			it "calls end_tournament"			
		end

		context "when it isn't the last round" do
			it "incraments the round by 1" do
				tournament.stub(:round).and_return(1)
				# lambda { tournament.next_round }.should change(:round, :to).by(2)
			end

			it "calculates each players prestige"

			it "matches up players"
		end
	end

	describe "#all_matches_finished?" do
		it "returns true when all matches are finished" do
			match = Match.new
			match.status = "finished"
			tournament.matches << match
			tournament.all_matches_finished?.should be_true
		end

		it "returns false when matches don't have a status of finished" do
			match = Match.new
			match.status = "running"
			tournament.matches << match
			tournament.all_matches_finished?.should be_false
		end
	end

  describe "#seed_first_round" do
  	it "sets round to 1"

  	it "shuffles the players"

  	it "calls match_players"

  	context "when the number of players is odd" do
  		it "adds a BYE player"
  	end

  	context "when the number of players is even" do
  		it "doesn't add a BYE player" do
  		end
  	end
  end

  describe "#match_players" do
  	context "when two players have already played each other" do
  		it "they can't play each other again" do
  			pending
  			(4).times do | i |
  				p = Player.new
  				p.name = "Player #{i.to_s}"
  				p.save
  				tournament.players << p
  			end

  			tournament.round = 1
  			tournament.match_players(tournament.players)
				
  			# Need to make a copy of this, instead of copying a pointer
				original_matches = tournament.matches.copy
				
				tournament.round = 2
				tournament.match_players(tournament.players)

  			tournament.matches.should_not == original_matches
  		end
  	end
  end

  describe "#create_match" do
  end

  describe "#match_players_first_to_last" do
  end

  describe "#total_number_of_rounds" do
  	it "returns 2 when there are 3 players" do
  		tournament.stub(:player_count).and_return(3)
  		tournament.total_number_of_rounds.should == 2
  	end

  	it "returns 2 when there are 4 players" do
  		tournament.stub(:player_count).and_return(4)
  		tournament.total_number_of_rounds.should == 2
  	end

  	it "returns 3 when there are 8 players" do
  		tournament.stub(:player_count).and_return(8)
  		tournament.total_number_of_rounds.should == 3
  	end

  	it "returns 4 when there are 16 players" do
  		tournament.stub(:player_count).and_return(16)
  		tournament.total_number_of_rounds.should == 4
  	end

  	it "returns 5 when there are 32 players" do
  		tournament.stub(:player_count).and_return(32)
  		tournament.total_number_of_rounds.should == 5
  	end

  	it "returns 6 when there are 100 players" do
  		tournament.stub(:player_count).and_return(100)
  		tournament.total_number_of_rounds.should == 6
  	end
  end

  describe "#tournament_players_sorted_by_prestige" do
  end
  
  describe "#players_sorted_by_prestige" do
  end

  describe "#finished?" do
  	context "when match is Finished" do
  		it "returns true" do
  			tournament.stub(:status).and_return("Finished")
  			tournament.finished?.should be_true
  		end
  	end

  	context "when match is Running" do
  		it "returns false" do
  			tournament.stub(:status).and_return("Running")
  			tournament.finished?.should be_false
	  	end
  	end
  end

  describe "#running?" do
  	context "when match is Finished" do
  		it "returns false" do
  			tournament.stub(:status).and_return("Finished")
  			tournament.running?.should be_false
  		end
  	end

  	context "when match is Running" do
  		it "returns true" do
  			tournament.stub(:status).and_return("Running")
  			tournament.running?.should be_true
	  	end
  	end
  end
end
