require 'spec_helper'

describe Player do
  let(:player) { FactoryGirl.create :player }

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

end
