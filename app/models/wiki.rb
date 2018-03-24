class Wiki < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :user
  
  scope :public_ones, -> { where(private: false) } 
  scope :private_ones, -> (current_user) { where(private: true, user: current_user) }
  
  validates :title, presence: true, length: { within: 8..140 }
  validates :body, presence: true, length: { within: 8..20000 }
  validates :user, presence: true
  
end
