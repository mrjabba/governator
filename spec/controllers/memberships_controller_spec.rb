require 'spec_helper'

describe MembershipsController do
 render_views

  describe "GET 'new'" do

    before(:each) do
      @group = Factory(:group)
    end

    it "should have the right title" do
      get :new, :group_id => @group

      response.should be_success
      response.should have_selector("title", :content => "New Membership")
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @group = Factory(:group)
    end

      describe "failure" do

        before(:each) do
          @attr = { :group_id => @group.id, :user_id => "" } 
        end

        it "should not create a membership" do
          lambda do
          post :create, :group_id => @group.id, :membership => @attr
          end.should_not change(Membership, :count)
        end

        it "should have the right title" do
          post :create, :group_id => @group.id, :membership => @attr
          response.should have_selector("title", :content => "New Membership")
        end

        it "should render the 'new' page" do
          post :create, :group_id => @group.id, :membership => @attr
          response.should render_template('new')
        end   

      end


      describe "success" do

        before(:each) do
          @user = Factory(:user)
          @attr = { :group_id => @group.id, :user_id => @user.id } 
        end


        it "should create a membership" do
          lambda do
            post :create, :membership => @attr
          end.should change(Membership, :count).by(1)
        end

        it "should redirect to the group show page" do
          post :create, :membership => @attr
          response.should redirect_to(group_path(assigns(:membership)))
        end   
        
        it "should have a flash message" do
          post :create, :membership => @attr
          flash[:success].should =~ /Membership created successfully/
        end

      end

  end
  
end
