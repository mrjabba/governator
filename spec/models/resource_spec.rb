require 'spec_helper'

describe Resource do

  before(:each) do
    @attr = { :name => "my resource" } 
  end

  it "should allow much larger resource column size"
  
  it "should create a new instance given valid attributes" do
    Resource.create!(@attr)
  end

  it "should require a name" do
    resource = Resource.new(@attr.merge(:name => ""))
    resource.should_not be_valid
  end
  
end
