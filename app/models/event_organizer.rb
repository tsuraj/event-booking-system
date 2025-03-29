class EventOrganizer < User 
  has_many :events, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end