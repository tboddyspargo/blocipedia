class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :wikis, dependent: :destroy
  enum role: [:standard, :premium, :admin]
  
  validates :role, presence: true
  validates :first_name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 20 }
  
  after_initialize :set_default_role
  
  def exist?
    self.is_a? User
  end
  
  private
  
    def set_default_role
      self.role ||= :standard
    end
  
end
