  require 'spec_helper'

describe Group do

  before(:each) do
    @attr = { :name => "mygroup" } 
  end
  
  it "should create a new instance given valid attributes" do
    Group.create!(@attr)
  end

  it "should require a name" do
    group = Group.new(@attr.merge(:name => ""))
    group.should_not be_valid
  end
  
end
