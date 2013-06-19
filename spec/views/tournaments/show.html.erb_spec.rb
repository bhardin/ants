require 'spec_helper'

describe "tournaments/show" do
  before(:each) do
    player2 = FactoryGirl.create (:player)
    player1 = FactoryGirl.create (:player)

    match = Match.new

    match.players << player1
    match.players << player2

    match.save

    @tournament = assign(:tournament, stub_model(Tournament,
      :name => "Name", :match => match
    ))

  end

  it "renders the tournament name in an h1" do
  	pending
    render
    rendered.should contain("Name".to_s)
  end

  it "renders a list of players" do
  	pending
  	render
    rendered.should contain(@tournament.players.to_s)
  end

	it "renders a list of players" do
		pending
  	render
    rendered.should contain(@tournament.matches.to_s)
  end

end
