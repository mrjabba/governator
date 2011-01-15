require 'spec_helper'

describe ResourcesController do
 render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end


  describe "GET 'new'" do

    before(:each) do
      @app = Factory(:app)
    end

    it "should be a restful controller"

    it "should have the right title" do
      get 'new', :app_id => @app.id

      response.should be_success
      response.should have_selector("title", :content => "New Resource")
    end
  end



  describe "PUT 'update'" do
    before(:each) do
      @resource = Factory(:resource)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @resource, :resource => @attr
        response.should render_template('edit')        
      end

      it "should have the right title" do
        put :update, :id => @resource, :resource => @attr
        response.should have_selector("title", :content => "Edit Resource")
      end

    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "my resource" }        
      end
      
      it "should change the resource's attributes" do
        put :update, :id => @resource, :resource => @attr
        resource = assigns(:resource)
        @resource.reload
        @resource.name.should  == resource.name
      end
      
      it "should redirect to the resource show page" do
        put :update, :id => @resource, :resource => @attr
        response.should redirect_to(resource_path(@resource))
      end
      
      it "should have a flash message" do
        put :update, :id => @resource, :resource => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end



  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
         @attr = { :name => "" } 
        end

        it "should not create an resource" do
          lambda do
            post :create, :resource => @attr
          end.should_not change(Resource, :count)
        end

        it "should have the right title" do
          post :create, :resource => @attr
          response.should have_selector("title", :content => "New Resource")
        end

        it "should render the 'new' page" do
          post :create, :resource => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @attr = { :name => "my resource" } 
        end

        it "should create a resource" do
          lambda do
            post :create, :resource => @attr
          end.should change(Resource, :count).by(1)
        end

        it "should redirect to the resource show page" do
          post :create, :resource => @attr
          response.should redirect_to(resource_path(assigns(:resource)))
        end   
        
        it "should have a flash message" do
          post :create, :resource => @attr
          flash[:success].should =~ /Resource created successfully/
        end

      end

  end

  
  describe "GET 'edit'" do
    
    before(:each) do
      @resource = Factory(:resource)
    end
    
     it "should be successful" do
      get :edit, :id => @resource
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @resource
      response.should have_selector("title", :content => "Edit Resource")
    end
    
  end

  describe "GET 'show'" do
  
    before(:each) do
      @resource = Factory(:resource)
    end
    
    it "should be successful" do
      get :show, :id => @resource
      response.should be_success
    end

    it "should find the right resource" do
      get :show, :id => @resource
      assigns(:resource).should == @resource
    end
    
    it "should have the right title" do
      get :show, :id => @resource
      response.should have_selector("title", :content => @resource.name)    
    end
    
    it "should include the resource's name" do
      get :show, :id => @resource
      response.should have_selector("h1", :content => @resource.name)
    end

  end

end
