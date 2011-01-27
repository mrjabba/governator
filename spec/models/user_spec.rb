  require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :username => "myuser" } 
  end

  it "should allow much larger username column size"
  
  it "should verify the scope :not_in_group works"
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a username" do
    user = User.new(@attr.merge(:username => ""))
    user.should_not be_valid
  end
  
end
