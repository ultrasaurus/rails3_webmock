require 'spec_helper'
require 'MD5'

CONFIG   = { :api_key => 'sPJ4jWvT1IPrEyOdHSWy502Gr9vh25E0WEnqIvLFCv8yTd3vHyFIm7aAQX6m2945', :api_version => 1.03 }
mobile   = '17187538692'
pass     = MD5.hexdigest mobile + 'whoami'
CREDS    = { :mobile => mobile, :pass => pass }
BASE_URI = 'http://api.3jam.com/webapi.php'
XPATH          = "//group"
MESSAGES_XPATH = "//eachmessage"
METHOD         = 'publicgroups.'
CREATE         = METHOD + 'add'
READ           = METHOD + 'view'
READ_MESSAGES  = METHOD + 'message.view'
DELETE         = METHOD + 'delete'

class Thing3

  def self.call(uri_string)

    method = CREATE
    params = CONFIG
    params.merge! :group_id => 2, :user_id => 1
    params_string = ''
    params.each { |k,v| params_string += "&#{k}=#{v}" }
    url         = URI.parse(URI.encode(BASE_URI + "?method=3jam." + method + params_string))
    Rails.logger.info "A request is being made at #{url}"
    response    = Net::HTTP.get(url)
    response

  end
end

describe Thing3 do
  it "should call a net API" do
    uri_string = "http://api.3jam.com/webapi.php?method=3jam.publicgroups.join&api_key=sPJ4jWvT1IPrEyOdHSWy502Gr9vh25E0WEnqIvLFCv8yTd3vHyFIm7aAQX6m2945&group_id=2&user_id=1&api_version=1.03"
    stub_request(:get, uri_string).to_return(:body => "something")
    Thing3.call(uri_string).should == "something"
    WebMock.should have_requested(:get, uri_string)
  end
end

