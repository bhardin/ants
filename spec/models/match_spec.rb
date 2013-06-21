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

  describe ".player_prestige(player)" do
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
