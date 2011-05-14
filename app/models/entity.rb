class Entity < ActiveRecord::Base
  #maybe a better name for entity would be assignment? a policy has assignments
  attr_accessible :policy_id, :permit
  belongs_to :entityable, :polymorphic => true
  belongs_to :policy  
  

end
