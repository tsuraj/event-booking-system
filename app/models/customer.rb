class Customer < User
  has_many :bookings, dependent: :destroy
  has_many :events, through: :bookings
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end