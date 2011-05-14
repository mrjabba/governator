module PolicyWonk
  DECISION_PERMIT = 1
  DECISION_INDETERMINATE = 0
  DECISION_DENY = -1    

  class Decision 
    def initialize()
      @pol = Policy
    end  

    def is_user_allowed(app_id, user_name, resource_name)
      policies = @pol.find_all_with_resource(app_id, resource_name)
      denials, permits = 0, 0
      found_resource, found_user = false, false
      policies.each{|policy| 
          policy.entities.each{|entity|
            found_resource = true if(entity_type_match(entity, 'Resource'))
            if(entity_type_match(entity, 'User') && user_name == entity.entityable.username)
              found_user = true
              permits += 1 if(entity.permit)
              denials += 1 if(!entity.permit)
            end
          }
      }
      result = eval_votes_for_decision(permits, denials)
      result = PolicyWonk::DECISION_INDETERMINATE if !found_user || !found_resource
      result
    end

    def is_group_allowed(app_id, group_name, resource_name)
      policies = @pol.find_all_with_resource(app_id, resource_name)
      denials, permits = 0, 0
      found_resource, found_group = false, false
      policies.each{|policy| 
          policy.entities.each{|entity|
            found_resource = true if(entity_type_match(entity, 'Resource'))
            if(entity_type_match(entity, 'Group') && group_name == entity.entityable.name)
              found_group = true
              permits += 1 if(entity.permit)
              denials += 1 if(!entity.permit)
            end
          }
      }
      result = eval_votes_for_decision(permits, denials)
      result = PolicyWonk::DECISION_INDETERMINATE if !found_group || !found_resource
      result
    end

    def policy=(policy)
      @pol = policy
    end

    private

      def entity_type_match(entity, target)
        entity.entityable.class.name == target
      end
      
      def eval_votes_for_decision(permits, denials)
        decision =  if denials > 0
                      PolicyWonk::DECISION_DENY
                    elsif denials == 0 && permits > 0
                      PolicyWonk::DECISION_PERMIT
                    elsif denials == 0 && permits == 0
                      PolicyWonk::DECISION_INDETERMINATE   
                    else
                      PolicyWonk::DECISION_INDETERMINATE   
                    end
        #puts "decision #{decision}"
        decision
      end  
  end

end
