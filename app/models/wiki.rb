class Wiki < ActiveRecord::Base
  include ApplicationHelper
  
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators, dependent: :destroy
  belongs_to :user
  alias_attribute :owner, :user
  
  scope :public_ones, -> { where(private: false) } 
  scope :private_ones, -> (current_user) { where(private: true, user: current_user) }
  
  validates :title, presence: true, length: { within: 8..140 }
  validates :body, presence: true, length: { within: 8..20000 }
  validates :owner, presence: true
  
  
  after_initialize :set_default_privacy
  
  def exist?
    self.is_a? Wiki
  end
  
  def mine?(current_user)
    self.owner == current_user
  end
  
  def public?
    not self.private
  end
  
  def private?
    self.private
  end
  
  def self.search(search_fields = {})
    query = []
    replacements = []
    search_fields.compact.each { |k,v| query << "#{k.to_s.downcase} LIKE ?"; replacements << "%#{v.to_s.downcase}%" }
    query_string = query.join(' AND ').strip
    search_criteria =  [query_string] + replacements
    query_string.empty? ? Wiki.all : Wiki.where(search_criteria)
  end
  
  private
  
    def set_default_privacy
      self.private ||= false
    end
  
end
