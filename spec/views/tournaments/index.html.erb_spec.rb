require 'spec_helper'

describe "tournaments/index" do
  before(:each) do
    assign(:tournaments, [
      stub_model(Tournament,
        :name => "Name"
      ),
      stub_model(Tournament,
        :name => "Name"
      )
    ])
  end

  it "renders a list of tournaments" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
