require 'helper'

describe WorldTimeEngine do
  after do
    WorldTimeEngine.reset!
  end

  describe "delegating to a client" do
    before do
      WorldTimeEngine.configure do |config|
        config.api_key = 'abc'
      end

      stub_request(:get, "http://worldtimeengine.com/api/ip/abc/193.174.32.100").
        to_return(:status => 200, :body => fixture('193.174.32.100.xml'), :headers => {})
    end

    it "requests the correct resource" do
      WorldTimeEngine.api('193.174.32.100')

      a_get("/api/ip/abc/193.174.32.100").should have_been_made
    end

    it "returns needed values" do
      response = WorldTimeEngine.api('193.174.32.100')

      response.version.should == '1.1'
      response.location.region.should == 'Germany'
      response.location.latitude.should == 53.25
      response.location.longitude.should == 10.4

      response.time.utc.should == Time.parse("2012-08-25 14:10:29 UTC")
      response.time.local.should == Time.parse("2012-08-25 16:10:29")

      response.time.zone.has_dst.should == true
      response.time.zone.current.abbreviation.should == "CEST"
      response.time.zone.current.description.should == "Central European Summer Time"
      response.time.zone.current.utc_offset.should == '+2:00'
      response.time.zone.current.is_dst.should == true
      response.time.zone.current.effective_until.should == Time.parse("2012-10-28 03:00:00")

      response.time.zone.next.abbreviation.should == 'CET'
      response.time.zone.next.description.should == "Central European Time"
      response.time.zone.next.utc_offset.should == "+1:00"
      response.time.zone.next.is_dst.should == false
      response.time.zone.next.effective_until.should == Time.parse("2013-03-31 02:00:00")
    end
  end

  describe ".client" do
    it "returns a WorldTimeEngine::Client" do
      WorldTimeEngine.client.should be_a WorldTimeEngine::Client
    end
  end

  describe ".configure" do
    it "sets the api_key" do
      WorldTimeEngine.configure do |config|
        config.api_key = 'abc'
      end
      WorldTimeEngine.instance_variable_get(:@api_key).should eq 'abc'
    end
  end

  describe ".credentials?" do
    it "returns true if all credentials are present" do
      WorldTimeEngine.configure do |config|
        config.api_key = 'CK'
      end
      WorldTimeEngine.credentials?.should be_true
    end
    it "returns false if any credentials are missing" do
      WorldTimeEngine.configure do |config|
      end
      WorldTimeEngine.credentials?.should be_false
    end
  end
end
