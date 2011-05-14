require 'spec_helper'

describe PolicyWonk::Decision do
  before do
    @app_id = 1
    @group_name = 'Deparmtent of the Elite'
    @resource = Resource.new(:name => 'resourceA')
    @policies = []
  end

  describe "Group allowed decisions on a resource" do

    describe "Policies contain a resource" do
      before(:each) do
        @entity_resource = Entity.new
        @entity_resource.entityable = @resource
      end

      describe "policies do not contain group" do
        it "should be indeterminate with a permit resource policy" do
          @entity_resource.permit = true
          @policies[0] = populate_test_policy([@entity_resource])
          decision = create_test_decision
          decision.is_group_allowed(@app_id, @group_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
        end
        
        it "should be indeterminate with a deny resource policy" do
          @entity_resource.permit = false
          @policies[0] = populate_test_policy([@entity_resource])
          decision = create_test_decision
          decision.is_group_allowed(@app_id, @group_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
        end
        
      end

      describe "policies contain group" do
        before(:each) do
            @group = Group.new(:name => @group_name)
            @entity_resource.permit = true
            @entity_group = Entity.new
            @entity_group.entityable = @group        
        end
      
          it "should be false when a policy contains deny for group"  do
            @entity_group.permit = false
            @policies[0] = populate_test_policy([@entity_resource, @entity_group])          
            decision = create_test_decision        
            decision.is_group_allowed(@app_id, @group_name, @resource.name).should == PolicyWonk::DECISION_DENY    
          end
          
          it "should be true when a policy contains deny for group" do
            @entity_group.permit = true
            @policies[0] = populate_test_policy([@entity_resource, @entity_group])          
            decision = create_test_decision
            decision.is_group_allowed(@app_id, @group_name, @resource.name).should == PolicyWonk::DECISION_PERMIT    
          end
      end

    end
    
    describe "Policies do not contain a resource" do
      it "should be indeterminate" do
        decision = create_test_decision
        decision.is_group_allowed(@app_id, @group_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
      end
    end
    
  end

  describe "User allowed decisions on a resource" do

    describe "Policies contain a resource" do
      before(:each) do
        @user_name = 'Fred'
        @entity_resource = Entity.new
        @entity_resource.entityable = @resource
      end

      describe "policies do not contain user" do
      
        it "should be indeterminate with a permit resource policy" do  
          @entity_resource.permit = true
          @policies[0] = populate_test_policy([@entity_resource])
          decision = create_test_decision
          decision.is_user_allowed(@app_id, @user_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
        end
        
        it "should be indeterminate with a deny resource policy" do  
          @entity_resource.permit = false
          @policies[0] = populate_test_policy([@entity_resource])
          decision = create_test_decision
          decision.is_user_allowed(@app_id, @user_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
        end

      end
  
      describe "policies contain user" do
        before(:each) do
            @user = User.new(:username => @user_name)
            @entity_resource.permit = true
            @entity_user = Entity.new
            @entity_user.entityable = @user        
        end

          it "should be false when a policy contains deny for user" do  
            @entity_user.permit = false
            @policies[0] = populate_test_policy([@entity_resource, @entity_user])          
            decision = create_test_decision        
            decision.is_user_allowed(@app_id, @user_name, @resource.name).should == PolicyWonk::DECISION_DENY    
          end

          it "should be true when a policy contains deny for user" do  
            @entity_user.permit = true
            @policies[0] = populate_test_policy([@entity_resource, @entity_user])          
            decision = create_test_decision
            decision.is_user_allowed(@app_id, @user_name, @resource.name).should == PolicyWonk::DECISION_PERMIT    
          end
      end
      
    end

    describe "Policies do not contain a resource" do
      it "should be indeterminate" do
        decision = create_test_decision
        decision.is_user_allowed(@app_id, @user_name, @resource.name).should == PolicyWonk::DECISION_INDETERMINATE    
      end
    end
    
  end


end
  
  private
  
  def populate_test_policy(entities)
    policy = Policy.new
    entities.each{|entity| policy.entities << entity } 
    policy
  end
  
  def create_test_decision
    decision = PolicyWonk::Decision.new
    decision.policy = setup_mock_policy
    decision
  end
  
  def setup_mock_policy
    mock_policy = mock('Policy')
    mock_policy.should_receive(:find_all_with_resource).and_return(@policies)
    mock_policy
  end
