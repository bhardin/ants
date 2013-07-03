require 'spec_helper'

describe Match do
	let(:match) { FactoryGirl.create :match }

  before :each do
    @player1 = Player.create(:name => "test player")
    @player2 = Player.create(:name => "test player2")
    @player3 = Player.create(:name => "test player3")
  end

  it "should have valid factory" do
    pending
    FactoryGirl.build(:match).should be_valid
  end

  describe "#finished?" do
    it "returns true if status is finished" do
      match.stub(:status).and_return(:finished)
      match.finished?.should be_true
    end

    it "returns false if status is running" do
      match.stub(:status).and_return(:running)
      match.finished?.should be_false
    end
  end

  describe "#update_score(match, params)" do
    context "when params['game_1_score']" do
      before do
        match.update_score(self, {"game_1_score" => "2 - 5"})
      end

      it "sets player_1_game_1_score to 2" do
        match.player_1_game_1_score.should be(2)
      end

      it "sets player_2_game_1_score to 5" do
        match.player_2_game_1_score.should be(5)
      end

      it "sets status to Game 1 Finished" do
        match.status.should == "Game 1 Finished"
      end
    end

    context "when params['game_2_score']" do
      before do
        match.update_score(self, {"game_2_score" => "10 - 2"})
      end

      it "sets player_1_game_1_score to 2" do
        match.player_1_game_2_score.should be(10)
      end

      it "sets player_2_game_1_score to 5" do
        match.player_2_game_2_score.should be(2)
      end

      it "sets status to Game 1 Finished" do
        match.status.should == "Game 2 Finished"
      end
    end
  end

  describe "#player_1" do
    it "returns player 1" do
      player_1 = FactoryGirl.build(:player)
      player_2 = FactoryGirl.build(:player)
      match.players << player_1
      match.players << player_2
      match.player_1.should == player_1
    end
  end

  describe "#player_2" do
    it "returns player 2" do
      player_1 = FactoryGirl.build(:player)
      player_2 = FactoryGirl.build(:player)
      match.players << player_1
      match.players << player_2
      match.player_2.should == player_2
    end
  end

  describe "#game_1_score" do
    it "returns the correct value" do
      match.stub(:player_1_game_1_score).and_return(5)
      match.stub(:player_2_game_1_score).and_return(10)
      match.game_1_score.should == "5 - 10"
    end
  end

  describe "#game_2_score" do
    it "returns the correct value" do
      match.stub(:player_1_game_1_score).and_return(2)
      match.stub(:player_2_game_1_score).and_return(1)
      match.game_1_score.should == "2 - 1"
    end
  end

  describe "#player_1_match_points" do
    it "returns the correct value" do
      match.stub(:player_1_game_1_score).and_return(2)
      match.stub(:player_1_game_2_score).and_return(1)
      match.player_1_match_points.should be(3)
    end
  end

  describe "#player_2_match_points" do
    it "returns the correct value" do
      match.stub(:player_2_game_1_score).and_return(2)
      match.stub(:player_2_game_2_score).and_return(10)
      match.player_2_match_points.should be(12)
    end
  end
  
  describe "#went_to_time?" do
    context "when the second game wasn't finished" do
      it "returns true" do
        match.stub(:player_1_game_2_score).and_return(5)
        match.stub(:player_2_game_2_score).and_return(5)
        match.went_to_time?.should be_true
      end
    end

    context "when the first game wasn't finished" do
      it "returns true" do
        match.stub(:player_1_game_1_score).and_return(5)
        match.stub(:player_2_game_1_score).and_return(5)
        match.went_to_time?.should be_true
      end
    end
  end

  describe "#finished_in_time?" do
    context "when the first and second games are finished" do
      it "returns true" do
        match.stub(:player_1_game_1_score).and_return(10)
        match.stub(:player_2_game_1_score).and_return(0)
        match.stub(:player_1_game_2_score).and_return(5)
        match.stub(:player_2_game_2_score).and_return(10)
        match.finished_in_time?.should be_true
      end
    end

    context "when the second game wasn't finished" do
      it "returns false" do
        match.stub(:player_1_game_1_score).and_return(10)
        match.stub(:player_2_game_1_score).and_return(0)
        match.stub(:player_1_game_2_score).and_return(5)
        match.stub(:player_2_game_2_score).and_return(1)
        match.finished_in_time?.should be_false
      end
    end
  end

  describe "#player_prestige(player)" do
    context "when first player won both games" do
      before :each do
        @match = Match.new
        @match.players << @player1
        @match.players << @player2
        @match.player_1_game_1_score = 10
        @match.player_2_game_1_score = 0
        @match.player_1_game_2_score = 10
        @match.player_2_game_2_score = 0
      end

      describe "first player" do
        it "has 6 prestige points" do
          @match.player_prestige(1).should == 6  
        end

        it "has 20 match points" do
          @match.player_1_match_points.should == 20
        end
      end

      describe "second player" do
        it "has 0 prestige points" do
          @match.player_prestige(2).should == 0
        end

        it "has 0 prestige points" do
          @match.player_2_match_points.should == 0
        end
      end
    end

    context "when second player won both games" do
      before :each do
        @match = Match.new
        @match.players << @player1
        @match.players << @player2
        @match.player_1_game_1_score = 2
        @match.player_2_game_1_score = 10
        @match.player_1_game_2_score = 2
        @match.player_2_game_2_score = 10
      end

      describe "first player" do
        it "has 0 prestige points" do
          @match.player_prestige(1).should == 0  
        end

        it "has 4 match points" do
          @match.player_1_match_points.should == 4
        end
      end

      describe "second player" do
        it "has 6 prestige points" do
          @match.player_prestige(2).should == 6
        end

        it "has 12 prestige points" do
          @match.player_2_match_points.should == 20
        end
      end
    end

    context "when first player scored 10,4 and second player scored 2,10" do
      before :each do
        @match = Match.new
        @match.players << @player1
        @match.players << @player2
        @match.player_1_game_1_score = 10
        @match.player_2_game_1_score = 2
        @match.player_1_game_2_score = 4
        @match.player_2_game_2_score = 10
      end

      describe "first player" do
        it "has 4 prestige points" do
          @match.player_prestige(1).should == 4
        end

        it "has 14 match points" do
          @match.player_1_match_points.should == 14
        end
      end

      describe "second player" do
        it "has 2 prestige points" do
          @match.player_prestige(2).should == 2
        end

        it "has 12 prestige points" do
          @match.player_2_match_points.should == 12
        end
      end
    end

    context "when first player and second player have equal scores" do
      before :each do
        @match = Match.new
        @match.players << @player1
        @match.players << @player2
        @match.player_1_game_1_score = 2
        @match.player_2_game_1_score = 10
        @match.player_1_game_2_score = 10
        @match.player_2_game_2_score = 2
      end

      describe "first player" do
        it "has 3 prestige points" do
          @match.player_prestige(1).should == 3  
        end

        it "has 12 match points" do
          @match.player_1_match_points.should == 12
        end
      end

      describe "second player" do
        it "has 3 prestige points" do
          @match.player_prestige(2).should == 3
        end

        it "has 12 prestige points" do
          @match.player_2_match_points.should == 12
        end
      end
    end

    context "when first game was 10, 3 and second game was 1, 4 (not completed)" do
      before :each do
        @match = Match.new
        @match.players << @player1
        @match.players << @player2
        @match.player_1_game_1_score = 10
        @match.player_2_game_1_score = 3
        @match.player_1_game_2_score = 1
        @match.player_2_game_2_score = 4
      end

      describe "first player" do
        it "has 5 prestige points" do
          @match.player_prestige(1).should == 5  
        end

        it "has 11 match points" do
          @match.player_1_match_points.should == 11
        end
      end

      describe "second player" do
        it "has 1 prestige points" do
          @match.player_prestige(2).should == 1
        end

        it "has 7 prestige points" do
          @match.player_2_match_points.should == 7
        end
      end
    end
  end

  describe "validation" do
    before :each do
      @match = Match.new
    end

    it "cant have 0 players" do
      @match.save
    end

    it "can't have 1 player" do
      pending
      @match.players << @player1
      @match.save.should raise_error("Not Enough Players")
      @match.errors.first
    end

    it "can have 2 players" do
      @match.players << @player1
      @match.players << @player2
      @match.save
    end

    it "can't have 3 players" do
      pending
      match.players << [@player1, @player2, @player3]
      match.save.should_not be_valid
    end
  end
end