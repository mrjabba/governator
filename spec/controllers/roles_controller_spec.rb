require 'spec_helper'

describe RolesController do
 render_views


  describe "GET 'new'" do

    before(:each) do
      @app = Factory(:app)
    end

    it "should be a restful controller"

    it "should have the right title" do
      get 'new', :app_id => @app.id

      response.should be_success
      response.should have_selector("title", :content => "New Role")
    end
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      @role = Factory(:role)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @role, :role => @attr
        response.should render_template('edit')        
      end

      it "should have the right title" do
        put :update, :id => @role, :role => @attr
        response.should have_selector("title", :content => "Edit Role")
      end

    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "my role" }        
      end
      
      it "should change the role's attributes" do
        put :update, :id => @role, :role => @attr
        role = assigns(:role)
        @role.reload
        @role.name.should  == role.name
      end
      
      it "should redirect to the role show page" do
        put :update, :id => @role, :role => @attr
        response.should redirect_to(role_path(@role))
      end
      
      it "should have a flash message" do
        put :update, :id => @role, :role => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end


  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
         @attr = { :name => "" } 
        end

        it "should not create an role" do
          lambda do
            post :create, :role => @attr
          end.should_not change(Role, :count)
        end

        it "should have the right title" do
          post :create, :role => @attr
          response.should have_selector("title", :content => "New Role")
        end

        it "should render the 'new' page" do
          post :create, :role => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @attr = { :name => "my role" } 
        end

        it "should create a role" do
          lambda do
            post :create, :role => @attr
          end.should change(Role, :count).by(1)
        end

        it "should redirect to the role show page" do
          post :create, :role => @attr
          response.should redirect_to(role_path(assigns(:role)))
        end   
        
        it "should have a flash message" do
          post :create, :role => @attr
          flash[:success].should =~ /Role created successfully/
        end

      end

  end

  describe "GET 'edit'" do
    
    before(:each) do
      @role = Factory(:role)
    end
    
     it "should be successful" do
      get :edit, :id => @role
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @role
      response.should have_selector("title", :content => "Edit Role")
    end
    
  end

  describe "GET 'show'" do
  
    before(:each) do
      @role = Factory(:role)
    end
    
    it "should be successful" do
      get :show, :id => @role
      response.should be_success
    end

    it "should find the right role" do
      get :show, :id => @role
      assigns(:role).should == @role
    end
    
    it "should have the right title" do
      get :show, :id => @role
      response.should have_selector("title", :content => @role.name)    
    end
    
    it "should include the role's name" do
      get :show, :id => @role
      response.should have_selector("h1", :content => @role.name)
    end

  end



end
