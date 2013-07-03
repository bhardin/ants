require 'spec_helper'

describe Tournament do
	let(:tournament) { FactoryGirl.create :tournament }
  let(:tournament_with_players) { FactoryGirl.create :tournament_with_players }

	it { tournament.should respond_to(:matches) }
	it { tournament.should respond_to(:players) } 	

	describe "#start_tournament" do
    it "changes status to Running" do
      tournament.start_tournament  
      tournament.status.should == "running"
		end

		it "seeds the first round" do
			tournament.should_receive :seed_first_round
      tournament.start_tournament
		end

    context "when tournament is already running" do
      it "throws an error" do
        tournament.stub(:status).and_return("running")
        expect { tournament.start_tournament }.to raise_error
      end
    end
	end

	describe "#current_round" do
		it "returns the round number" do
			tournament.stub(:round).and_return(5)
			tournament.current_round.should be(5)
		end
	end

	describe "#end_tournament" do
		it "sets the status as finished" do
      tournament.end_tournament 
      tournament.status.should == "finished"
    end
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
			it "calls end_tournament" do
        tournament.stub(:total_number_of_rounds).and_return(3)
        tournament.stub(:round).and_return(3)
        tournament.should_receive :end_tournament
        tournament.next_round
      end
		end

		context "when it isn't the last round" do
      before :each do
        tournament.start_tournament
      end

			it "incraments the round by 1" do
        expect { tournament.next_round }.to change { tournament.round }.by(1)
			end

			it "calculates each players prestige" do
        tournament.should_receive :calculate_each_players_prestige
        tournament.next_round
      end

			it "matches up players" do
        tournament.should_receive :match_players
        tournament.next_round
      end
		end
	end

	describe "#all_matches_finished?" do
		it "returns true when all matches are finished" do
      tournament.matches.each do | match |
        match.stub(:status).and_return(:finished)  
      end
			tournament.all_matches_finished?.should be_true
		end

		it "returns false when matches don't have a status of finished" do
			tournament.matches.each do | match |
        match.stub(:status).and_return(:running)  
      end
			tournament.all_matches_finished?.should be_false
		end
	end

  describe "#seed_first_round" do
  	it "sets round to 1" do
      expect { tournament.seed_first_round }.to change{ tournament.round }.to(1)
    end

  	it "calls match_players" do
      tournament.start_tournament
      tournament.should_receive :match_players
      tournament.next_round
    end

  	context "when the number of players is odd" do
  		it "adds a BYE player"
  	end

  	context "when the number of players is even" do
  		it "doesn't add a BYE player"
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
  			tournament.stub(:status).and_return("finished")
  			tournament.finished?.should be_true
  		end
  	end

  	context "when match is running" do
  		it "returns false" do
  			tournament.stub(:status).and_return("running")
  			tournament.finished?.should be_false
	  	end
  	end
  end

  describe "#running?" do
  	context "when match is Finished" do
  		it "returns false" do
  			tournament.stub(:status).and_return("finished")
  			tournament.running?.should be_false
  		end
  	end

  	context "when match is Running" do
  		it "returns true" do
  			tournament.stub(:status).and_return("running")
  			tournament.running?.should be_true
	  	end
  	end
  end
end
