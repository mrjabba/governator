require 'spec_helper'

describe UsersController do
 render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do

    before(:each) do
      @appgroup = Factory(:appgroup)
    end

    it "should have the right title" do
      get 'new', :appgroup_id => @appgroup.id

      response.should be_success
      response.should have_selector("title", :content => "New User")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :username => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')        
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit User")
      end

    end
    
    describe "success" do
      before(:each) do
        @attr = { :username => "userfoo" }        
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        user = assigns(:user)
        @user.reload
        @user.username.should  == user.username
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end

  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
          @appgroup = Factory(:appgroup)
          @attr = { :username => "" } 
        end

        it "should not create an user" do
          lambda do
            post :create, :appgroup_id => @appgroup.id, :user => @attr
          end.should_not change(User, :count)
        end

        it "should have the right title" do
          post :create, :appgroup_id => @appgroup.id, :user => @attr
          response.should have_selector("title", :content => "New User")
        end

        it "should render the 'new' page" do
          post :create, :appgroup_id => @appgroup.id, :user => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @appgroup = Factory(:appgroup)
         @attr = { :username => "userfoo" } 
        end

        it "should create a user" do
          lambda do
            post :create, :appgroup_id => @appgroup.id, :user => @attr
          end.should change(User, :count).by(1)
        end

        it "should redirect to the user show page" do
          post :create, :appgroup_id => @appgroup.id, :user => @attr
          response.should redirect_to(user_path(assigns(:user)))
        end   
        
        it "should have a flash message" do
          post :create, :appgroup_id => @appgroup.id, :user => @attr
          flash[:success].should =~ /User created successfully/
        end

      end

  end

  
  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
     it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit User")
    end
    
  end

  describe "GET 'show'" do
  
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.username)    
    end
    
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.username)
    end

  end


end
