class Wiki < ActiveRecord::Base
  belongs_to :user
  
  scope :public_ones, -> { where(private: false) } 
  scope :private_ones, -> { where(private: true, user: current_user) }
end
