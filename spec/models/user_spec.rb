  require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :username => "myuser" } 
  end
  
  it "should verify the scope :not_in_group works"
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a username" do
    user = User.new(@attr.merge(:username => ""))
    user.should_not be_valid
  end

  it "should validate max username length" do
    too_big_string = ""
    201.times {too_big_string = too_big_string + "a"}
    user = User.new(@attr.merge(:username => too_big_string ))
    user.should_not be_valid
  end
  
end
