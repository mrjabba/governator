class Entity < ActiveRecord::Base
  attr_accessible :policy_id, :permit
  belongs_to :entityable, :polymorphic => true
  belongs_to :policy  
end
