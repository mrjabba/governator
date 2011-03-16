class Policy < ActiveRecord::Base
  attr_accessible :app_id
  belongs_to :app
  has_many :entities
end
