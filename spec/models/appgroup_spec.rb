require 'spec_helper'

describe Appgroup do

  before(:each) do
    @attr = { :name => "my appgroup" } 
  end

  it "should allow much larger appgroup column size"
  
  it "should create a new instance given valid attributes" do
    Appgroup.create!(@attr)
  end

  it "should require a name" do
    appgroup = Appgroup.new(@attr.merge(:name => ""))
    appgroup.should_not be_valid
  end
  
end
