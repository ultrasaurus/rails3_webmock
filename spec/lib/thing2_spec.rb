require 'spec_helper'

class Thing2
  def self.call(uri_string)
    uri = URI.parse("http://www.google.com?a=1&b=2&c=3")
    result = Net::HTTP.get(uri)
  end
end

describe Thing2 do
  it "should call a net API" do
    uri_string = "http://www.google.com?a=1&b=2&c=3"
    stub_request(:get, uri_string).to_return(:body => "something")
    Thing2.call(uri_string).should == "something"
    WebMock.should have_requested(:get, uri_string)
  end
end

