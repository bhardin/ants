require 'spec_helper'

describe Tournament do
	let(:tournament) { FactoryGirl.create :tournament }

	it { tournament.should respond_to(:matches) }
	it { tournament.should respond_to(:players) } 	

end
