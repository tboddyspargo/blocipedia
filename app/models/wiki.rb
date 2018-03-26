class Wiki < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :user
  
  after_initialize :init
  
  scope :public_ones, -> { where(private: false) } 
  scope :private_ones, -> (current_user) { where(private: true, user: current_user) }
  
  validates :title, presence: true, length: { within: 8..140 }
  validates :body, presence: true, length: { within: 8..20000 }
  validates :user, presence: true
  
  def init
    self.private = false if self.private.nil?
  end
  
end
