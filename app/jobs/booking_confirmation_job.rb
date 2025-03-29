class BookingConfirmationJob < ApplicationJob
  queue_as :default

  
  def perform(email, event)
    puts "Sending booking confirmation email to #{email} for event #{event}."
  end

end
