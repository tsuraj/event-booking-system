class EventUpdateNotificationJob < ApplicationJob
  queue_as :default

  def perform(event)
    customers = event.bookings.includes(:customer).map(&:customer).uniq
    customers.each do |customer|
      puts "Notifying #{customer.email} about event updates for #{event.title}."
    end
  end
end