require 'spec_helper'

describe AppgroupsController do
  render_views

  describe "GET 'new'" do

    before(:each) do
    end

    it "should have the right title" do
      get 'new'
      response.should be_success
      response.should have_selector("title", :content => "New Application Group")
    end
  end

  describe "GET 'index'" do
    it "should have the right title" do
      get 'index'
      response.should be_success
      response.should have_selector("title", :content => "Application Group Repository")
    end
  end


  describe "GET 'show'" do
  
    before(:each) do
      @appgroup = Factory(:appgroup)
    end
    
    it "should be successful" do
      get :show, :id => @appgroup
      response.should be_success
    end
    
    it "should find the right appgroup" do
      get :show, :id => @appgroup
      assigns(:appgroup).should == @appgroup
    end
    
    it "should have the right title" do
      get :show, :id => @appgroup
      response.should have_selector("title", :content => @appgroup.name)    
    end
    
    it "should include the appgroup's name" do
      get :show, :id => @appgroup
      response.should have_selector("h1", :content => @appgroup.name)
    end
      
  end

end
