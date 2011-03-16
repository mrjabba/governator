class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :last_name, :appgroup_id
  validates_lengths_from_database
  
  has_many :memberships
  has_many :groups, :through => :memberships
  belongs_to :appgroup
  has_many :entities, :as => :entityable

  scope :not_in_group, lambda { |group|  
      join_clause = User.send(:sanitize_sql_array, 
        ["LEFT OUTER JOIN memberships ON memberships.user_id = users.id WHERE memberships.group_id <> ? or memberships.group_id is null", group ])  
        User.select("distinct(users.id), users.*").joins(join_clause) 
  }
 
    validates :username, :presence => true,
                  :length   => { :maximum => 200 }


  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
