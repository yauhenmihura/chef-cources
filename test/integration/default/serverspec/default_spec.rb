require 'serverspec'

# Required by serverspec
set :backend, :exec

# Check jenkins port
describe "Jenkins port is listenning" do 
	it "Port is listenning 200 OK" do
		expect(port(8081)).to be_listening
	end
end

# Check jenkins port equal 1
describe process("jenkins") do
	its(:count) { should eq 1 }
end

# Check 22 port
describe port(22) do
  	it { should be_listening }
end

