require 'spec_helper'

describe "Tournaments" do
  describe "GET /tournaments" do
    it "works! (now write some real specs)" do
      visit tournaments_path
      response.status.should be(200)
    end
  end
end
