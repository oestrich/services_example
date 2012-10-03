require 'spec_helper'
require 'http_spec/clients/rack'

describe "Services" do
  before do
    HTTPSpec.client = HTTPSpec::Clients::Rack.new(Rails.application)
  end

  let!(:user) { User.create(:email => "eric@example.com", :password => "password", :password_confirmation => "password") }

  it "should create an order" do
    response = post "/orders", "order[name]=Tea", "Accept" => "application/json"

    response.body.should be_json_eql({
      :name => "Tea",
      :user_id => user.id
    }.to_json)

    response.status.should == 201
  end

  it "should require the name parameter" do
    response = post "/orders", "", "Accept" => "application/json"

    response.body.should be_json_eql({
      :name => ["can't be blank"]
    }.to_json)

    response.status.should == 422
  end
end
