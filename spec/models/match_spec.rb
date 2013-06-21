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

      it "first player has 6 points" do
        @match.player_prestige(1).should == 6
      end

      it "second player has 0 points" do
        @match.player_prestige(2).should == 0
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

      it "first player has 0 points" do
        @match.player_prestige(1).should == 0
      end

      it "second player has 6 points" do
        @match.player_prestige(2).should == 6
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

      it "first player has 4 points" do
        @match.player_prestige(1).should == 4
      end

      it "second player has 2 points" do
        @match.player_prestige(2).should == 2
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

      it "first player has 3 points" do
        @match.player_prestige(1).should == 3
      end

      it "second player has 3 points" do
        @match.player_prestige(2).should == 3
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
