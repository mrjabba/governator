require 'spec_helper'

describe Resource do

  before(:each) do
    @attr = { :name => "my resource"} 
  end

  it "should create a new instance given valid attributes" do
    Resource.create!(@attr)
  end

  it "should require a name" do
    resource = Resource.new(@attr.merge(:name => ""))
    resource.should_not be_valid
  end

  it "should validate max name length" do
    too_big_string = ""
    2001.times {too_big_string = too_big_string + "a"}
    resource = Resource.new(@attr.merge(:name => too_big_string ))
    resource.should_not be_valid
  end

end
