class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators, dependent: :destroy
  has_many :wikis
  enum role: [:standard, :premium, :admin]
  
  validates :role, presence: true
  validates :first_name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 20 }
  
  after_initialize :set_default_role
  
  def exist?
    self.is_a? User
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  protected
  
    def search(search_string)
      if search_string
        search_string.downcase!
        where('LOWER(email) = :search_string', search_string: search_string)
      else 
        all
      end
    end
  
  private
  
    def set_default_role
      self.role ||= :standard
    end
  
end
