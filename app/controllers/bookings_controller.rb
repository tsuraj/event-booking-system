class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_customer?
  
    def create
      byebug
      event = Event.find(params[:event_id])
      ticket = event.tickets.find(params[:ticket_id])
      
      if ticket.quantity < params[:quantity].to_i
        return render json: { error: "Not enough tickets available" }, status: :unprocessable_entity
      end
  
      booking = current_user.bookings.new(
        event: event,
        ticket: ticket,
        quantity: params[:quantity]
      )
  
      if booking.save
        ticket.update(quantity: ticket.quantity - params[:quantity].to_i)
        BookingConfirmationJob.perform_later(current_user.email, booking.event.title)
        render json: booking, status: :created
      else
        render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def is_customer?
      if not current_user.type =="Customer"
        render json: {error:  "You don't have access for Booking Access"}
        #raise "You don't have access for Event Management"
      end
    end

  end
  