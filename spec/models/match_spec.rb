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
