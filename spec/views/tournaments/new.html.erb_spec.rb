require 'spec_helper'

describe "tournaments/new" do
  before(:each) do
    assign(:tournament, stub_model(Tournament,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new tournament form" do
    render

    rendered.should have_selector("form", :action => tournaments_path, :method => "post") do |form|
      form.should have_selector("input#tournament_name", :name => "tournament[name]")
    end
  end
end
