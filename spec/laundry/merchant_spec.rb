require 'spec_helper'

describe Laundry::PaymentsGateway::Merchant do

	let(:merchant) { build :merchant }

	describe "#find" do


  #before do
    #Laundry.stub!
  #end
			it "returns a client" do
        #debugger
				merchant.clients.find(10).class.should == Laundry::PaymentsGateway::Client
			end

			it "client should have an id" do
        debugger
				merchant.clients.find(10).id.should == "1"
			end

	end

end
