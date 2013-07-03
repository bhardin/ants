require 'spec_helper'

describe Player do
  let(:player) { FactoryGirl.create :player }
  let(:another_player) { FactoryGirl.create :player }

  it "has a name" do
  	player.should respond_to(:name)
  end

  it "name should be unique" do
    name = player.name
    Player.new(:name => name).should_not be_valid
  end

  it "belongs to many matches" do
  	player.should respond_to(:matches)
  end

  it "belongs to tournaments" do
    player.should respond_to(:tournaments)
  end

  it "name needs to be present" do
  	player = Player.new
  	player.save.should be_false
  end

  describe "#has_played?(player)" do
    before :each do
      setup_a_match
    end

    context "when played another player" do
      it "returns true" do
        @player.has_played?(@another_player).should be_true
      end
    end

    context "when hasn't played another player" do
      it "returns false" do
        @player.has_played?(@yet_another_player).should be_false
      end
    end
  end

  describe "#has_not_played?(player)" do
    before :each do
      setup_a_match
    end

    context "when played another player" do
      it "returns false" do
        @player.has_not_played?(@another_player).should be_false
      end
    end

    context "when hasn't played another player" do
      it "returns true" do
        @player.has_not_played?(@yet_another_player).should be_true
      end
    end
  end
end

def setup_a_match
  @match = FactoryGirl.create :match
  @player = FactoryGirl.create :player
  @another_player = FactoryGirl.create :player
  @yet_another_player = FactoryGirl.create :player
  @match.players << @player
  @match.players << @another_player
end
