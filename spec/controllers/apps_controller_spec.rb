require 'spec_helper'

describe AppsController do
 render_views

  describe "GET 'index'" do
    it "bring back apps view"
  end


  describe "GET 'new'" do

    before(:each) do
      @appgroup = Factory(:appgroup)
    end

    it "should have the right title" do
      get 'new', :appgroup_id => @appgroup.id

      response.should be_success
      response.should have_selector("title", :content => "New App")
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      @app = Factory(:app)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @app, :app => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @app, :app => @attr
        response.should have_selector("title", :content => "Edit Application")
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "my app" }        
      end
      
      it "should change the app's attributes" do
        put :update, :id => @app, :app => @attr
        app = assigns(:app)
        @app.reload
        @app.name.should  == app.name
      end
      
      it "should redirect to the app show page" do
        put :update, :id => @app, :app => @attr
        response.should redirect_to(app_path(@app))
      end
      
      it "should have a flash message" do
        put :update, :id => @app, :app => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end


  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
          @appgroup = Factory(:appgroup)
          @attr = { :name => "" } 
        end

        it "should not create an app" do
          lambda do
            post :create, :appgroup_id => @appgroup.id, :app => @attr
          end.should_not change(App, :count)
        end

        it "should have the right title" do
          post :create, :appgroup_id => @appgroup.id, :app => @attr
          response.should have_selector("title", :content => "New Application")
        end

        it "should render the 'new' page" do
          post :create, :appgroup_id => @appgroup.id, :app => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @appgroup = Factory(:appgroup)
         @attr = { :name => "my app" } 
        end

        it "should create an app" do
          lambda do
            post :create, :appgroup_id => @appgroup.id, :app => @attr
           end.should change(App, :count).by(1)
        end

        it "should redirect to the app show page" do
          post :create, :appgroup_id => @appgroup.id, :app => @attr
          response.should redirect_to(app_path(assigns(:app)))
        end   
        
        it "should have a flash message" do
          post :create, :appgroup_id => @appgroup.id, :app => @attr
          flash[:success].should =~ /Application created successfully/
        end

      end

  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @app = Factory(:app)
    end
    
     it "should be successful" do
      get :edit, :id => @app
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @app
      response.should have_selector("title", :content => "Edit Application")
    end
    
    
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
