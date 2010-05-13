require 'spec_helper'

class Thing
  def self.call(uri_string)
    uri = URI.parse("http://www.google.com")
    result = Net::HTTP.get(uri)
  end
end

describe Thing do
  it "should call a net API" do
    uri_string = "http://www.google.com"
    stub_request(:get, uri_string).to_return(:body => "something")
    Thing.call(uri_string).should == "something"
    WebMock.should have_requested(:get, uri_string)
  end
end

