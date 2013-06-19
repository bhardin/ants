require 'spec_helper'

describe "tournaments/edit" do
  before(:each) do
    @tournament = assign(:tournament, stub_model(Tournament,
      :name => "MyString"
    ))
  end

  it "renders the edit tournament form" do
    render

    rendered.should have_selector("form", :action => tournament_path(@tournament), :method => "post") do |form|
      form.should have_selector("input#tournament_name", :name => "tournament[name]")
    end
  end
end
