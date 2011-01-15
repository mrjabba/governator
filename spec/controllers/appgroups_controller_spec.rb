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

  describe "PUT 'update'" do
    before(:each) do
      @appgroup = Factory(:appgroup)
   end
    
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @appgroup, :appgroup => @attr
        response.should render_template('edit')        
      end

      it "should have the right title" do
        put :update, :id => @appgroup, :appgroup => @attr
        response.should have_selector("title", :content => "Edit Application Group")
      end

    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "my appgroup" }        
      end
      
      it "should change the appgroup's attributes" do
        put :update, :id => @appgroup, :appgroup => @attr
        appgroup = assigns(:appgroup)
        @appgroup.reload
        @appgroup.name.should  == appgroup.name
      end
      
      it "should redirect to the appgroup show page" do
        put :update, :id => @appgroup, :appgroup => @attr
        response.should redirect_to(appgroup_path(@appgroup))
      end
      
      it "should have a flash message" do
        put :update, :id => @appgroup, :appgroup => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
  end


  describe "POST 'create'" do
      describe "failure" do

        before(:each) do
         @attr = { :name => "" } 
        end

        it "should not create an appgroup" do
          lambda do
            post :create, :appgroup => @attr
          end.should_not change(Appgroup, :count)
        end

        it "should have the right title" do
          post :create, :appgroup => @attr
          response.should have_selector("title", :content => "New Application Group")
        end

        it "should render the 'new' page" do
          post :create, :appgroup => @attr
          response.should render_template('new')
        end   

      end

      describe "success" do

        before(:each) do
         @attr = { :name => "my appgroup" } 
        end

        it "should create a appgroup" do
          lambda do
            post :create, :appgroup => @attr
          end.should change(Appgroup, :count).by(1)
        end

        it "should redirect to the appgroup show page" do
          post :create, :appgroup => @attr
          response.should redirect_to(appgroup_path(assigns(:appgroup)))
        end   
        
        it "should have a flash message" do
          post :create, :appgroup => @attr
          flash[:success].should =~ /Application Group created successfully/
        end

      end

  end


  describe "GET 'edit'" do
    
    before(:each) do
      @appgroup = Factory(:appgroup)
    end
    
     it "should be successful" do
      get :edit, :id => @appgroup
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @appgroup
      response.should have_selector("title", :content => "Edit Application Group")
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
