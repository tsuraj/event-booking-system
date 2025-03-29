class Ticket < ApplicationRecord
  belongs_to :event
  
  validates :ticket_type, :price, :quantity, presence: true
end
