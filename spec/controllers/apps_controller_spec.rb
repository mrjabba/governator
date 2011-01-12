require 'spec_helper'

describe AppsController do
 render_views

  describe "GET 'new'" do
    it "should be a restful controller"
  end
  
  describe "GET 'show'" do
  
    before(:each) do
      @app = Factory(:app)
    end
    
    it "should be successful" do
      get :show, :id => @app
      response.should be_success
    end

    it "should find the right app" do
      get :show, :id => @app
      assigns(:app).should == @app
    end
    
    it "should have the right title" do
      get :show, :id => @app
      response.should have_selector("title", :content => @app.name)    
    end
    
    it "should include the app's name" do
      get :show, :id => @app
      response.should have_selector("h1", :content => @app.name)
    end
      
  end
  
  


end
