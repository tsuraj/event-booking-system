class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action  :is_event_organizer?
    
    def index
      events = Event.all
      render json: events
    end
  
    def show
      event = Event.find(params[:id])
      render json: event
    end
  
    def create
      event = current_user.events.new(event_params)
      if event.save
        render json: event, status: :created
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      event = current_user.events.find(params[:id])
      if event.update(event_params)
        EventUpdateNotificationJob.perform_later(event)
        render json: event
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      event = current_user.events.find(params[:id])
      event.destroy
      render json: { message: 'Event deleted successfully' }
    end
  
    private

    def is_event_organizer?
        if not current_user.type =="EventOrganizer"
            render json: {error:  "You don't have access for Event Management"}
            #raise "You don't have access for Event Management"
        end
    end
  
    def event_params
      params.require(:events).permit(:title, :date, :venue)
    end
  end
  