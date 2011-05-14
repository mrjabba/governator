class Policy < ActiveRecord::Base
  attr_accessible :app_id
  belongs_to :app
  has_many :entities
  
  #find all policies for this resource
  def self.find_all_with_resource(app_id, resource_name)

    puts "zzz dont call me use mock"
#something like this @policies =  Policy.includes([:entity]).find_all_by_resource_name(:resource_name)
    #make sure to return only policies for this application..change method sig


#    policies = Policy.find_all_by_app_id(app_id)
=begin
    apps = App.all
    puts "apps #{apps.size}"
    puts "appsf #{apps.first.attributes}"
    puts "appsl #{apps.last.attributes}"

    appgroups = Appgroup.all
    puts "appgroups #{appgroups.size}"
    puts "appgroupsf #{appgroups.first.attributes}"
    puts "appgroupsl #{appgroups.last.attributes}"

    res = Resource.all
    puts "res #{res.size}"

    policies = Policy.all
    puts "policies #{policies.size}"

    entity = Entity.all
    puts "entity #{entity.size}"
    
    puts policies.first.attributes
    puts policies.size
=end    
    
#  Entity.joins(:policy).find_by_id(1)
#Entity.joins(:policy).where(:policy_id => 2)
=begin
  check the rails 3 way book
  we need to query and join policies and entities and resources
  while we could prob do this all manually.
  we should find an active record way to do it.
  basically, we want to product this sql
  select e.*, p.app_id  from 
    policies p,
    entities e,
    resources r
    where
    e.policy_id = p.id
    and e.entityable_id = r.id
    and e.entityable_type = 'Resource'
    and p.app_id = 2
    and r.name = 'meh'
    this would do it basically..
    http://guides.rubyonrails.org/active_record_querying.html

=end

  end
  
  

  
end
