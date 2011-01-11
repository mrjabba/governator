require 'spec_helper'

describe Role do

  before(:each) do
    @attr = { :name => "my role", :description => "important role" } 
  end

  it "should allow much larger role column size"
  
  it "should create a new instance given valid attributes" do
    Role.create!(@attr)
  end

  it "should require a name" do
    role = Role.new(@attr.merge(:name => ""))
    role.should_not be_valid
  end
  
end
