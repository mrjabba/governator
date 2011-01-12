require 'spec_helper'

describe App do

  before(:each) do
    @attr = { :name => "my app" } 
  end

  it "remove search from this model?"

  it "should allow much larger app column size"
  
  it "should create a new instance given valid attributes" do
    App.create!(@attr)
  end

  it "should require a name" do
    app = App.new(@attr.merge(:name => ""))
    app.should_not be_valid
  end
  
end
