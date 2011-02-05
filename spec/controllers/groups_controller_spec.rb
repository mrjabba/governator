require 'spec_helper'

describe GroupsController do
 render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do

    before(:each) do
    end

    it "should have the right title" do
      get 'new'

      response.should be_success
      response.should have_selector("title", :content => "New Group")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @group = Factory(:group)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @group, :group => @attr
        response.should render_template('edit')        
      end

      it "should have the right title" do
        put :update, :id => @group, :group => @attr
        response.should have_selector("title", :content => "Edit Group")
      end

    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "my group" }        
      end
      
      it "should change the group's attributes" do
        put :update, :id => @group, :group => @attr
        group = assigns(:group)
        @group.reload
        @group.name.should  == group.name
      end
      
      it "should redirect to the group show page" do
        put :update, :id => @group, :group => @attr
        response.should redirect_to(group_path(@group))
      end
      
      it "should have a flash message" do
        put :update, :id => @group, :group => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end

  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
         @attr = { :name => "" } 
        end

        it "should not create a group" do
          lambda do
            post :create, :group => @attr
          end.should_not change(Group, :count)
        end

        it "should have the right title" do
          post :create, :group => @attr
          response.should have_selector("title", :content => "New Group")
        end

        it "should render the 'new' page" do
          post :create, :group => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @attr = { :name => "my group" } 
        end

        it "should create a group" do
          lambda do
            post :create, :group => @attr
          end.should change(Group, :count).by(1)
        end

        it "should redirect to the group show page" do
          post :create, :group => @attr
          response.should redirect_to(group_path(assigns(:group)))
        end   
        
        it "should have a flash message" do
          post :create, :group => @attr
          flash[:success].should =~ /Group created successfully/
        end

      end

  end

  describe "GET 'edit'" do
    
    before(:each) do
      @group = Factory(:group)
    end
    
     it "should be successful" do
      get :edit, :id => @group
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @group
      response.should have_selector("title", :content => "Edit Group")
    end
    
  end

  describe "GET 'show'" do
  
    before(:each) do
      @group = Factory(:group)
    end
    
    it "should be successful" do
      get :show, :id => @group
      response.should be_success
    end

    it "should find the right group" do
      get :show, :id => @group
      assigns(:group).should == @group
    end
    
    it "should have the right title" do
      get :show, :id => @group
      response.should have_selector("title", :content => @group.name)    
    end
    
    it "should include the group's name" do
      get :show, :id => @group
      response.should have_selector("h1", :content => @group.name)
    end

  end


end
