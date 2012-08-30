require "rspec/mocks/standalone"
require 'factory_girl'
factories_dir = File.expand_path File.join(__FILE__, "..", "..", "..", "spec", "factories")
puts factories_dir
FactoryGirl.definition_file_paths = [factories_dir]
FactoryGirl.find_definitions
include FactoryGirl::Syntax::Methods

class Module
	def subclasses
		classes = []
		ObjectSpace.each_object(Module) do |m|
			classes << m if m.ancestors.include? self
		end
		classes
	end
end

# Just stub away all the SOAP requests and such.
classes = [Laundry::PaymentsGateway::MerchantAuthenticatableDriver, Laundry::PaymentsGateway::Merchant]
classes.map{|c| [c.subclasses, c] }.flatten.uniq.each do |klass|
	klass.stub(:client_request).and_return true
	klass.stub(:client).and_return true
	klass.any_instance.stub(:setup_client!).and_return true
end

# Stub client driver
Laundry::PaymentsGateway::ClientDriver.any_instance.stub(:find).and_return(build(:client))
Laundry::PaymentsGateway::ClientDriver.any_instance.stub(:create!).and_return(build(:client).id)


# Stub account driver
Laundry::PaymentsGateway::AccountDriver.any_instance.stub(:find).and_return(build(:account))
Laundry::PaymentsGateway::AccountDriver.any_instance.stub(:create!).and_return(build(:account).id)

# Stub performing transactions.
Laundry::PaymentsGateway::Account.any_instance.stub(:perform_transaction).and_return(build(:transaction_response))