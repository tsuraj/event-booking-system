class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :tickets, dependent: :destroy
  has_many :bookings, dependent: :destroy
  
  validates :title, :date, :venue, presence: true
end
