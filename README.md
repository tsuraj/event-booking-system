# README

**Event Booking System (Ruby on Rails)**

## Overview

This is a backend API for an Event Booking System built with Ruby on Rails. It supports authentication for Event Organizers and Customers, role-based access control, event creation, ticket booking, and background jobs using Sidekiq.

* Tech Stack

  Ruby on Rails (API mode)
  
  PostgreSQL (Database)
  
  Devise + JWT (Authentication)
  
  Sidekiq + Redis (Background Jobs)
  


**Setup Instructions**

Prerequisites

Ensure you have the following installed:

  Ruby 2.7.6
  
  Rails 7.x
  
  PostgreSQL
  
  Redis (for Sidekiq)
  
  Bundler

1. Clone the Repository

  git clone 
  cd event_booking_system

2. Install Dependencies

  bundle install

3. Configure Database

  Update config/database.yml with your PostgreSQL credentials if needed.
  Then, create and migrate the database:

  rails db:create
  rails db:migrate


5. Start the Server

  rails s
  in case of error related to secret_key_base, run(if using vscode) this command: EDITOR="code --wait" rails credentials:edit



**Authentication & User Roles**

User Types:

  Event Organizers can create, update, and manage events.
  
  Customers can browse events and book tickets.

Login & Authentication

  Authentication is handled via JWT tokens.
  
  To register or log in, use the Devise JWT endpoints:

  POST /users/sign_in 
  On successful login, you’ll receive a JWT token. Include this token in requests:
  
  Authorization: Bearer <token>

**API Endpoints**

Event Management 
  
  GET /events - List all events
  
  GET /events/:id - View an event
  
  POST /events - Create an event
  
  PUT /events/:id - Update an event
  
  DELETE /events/:id - Delete an event
  
  Booking API (Only for Customers)
  
  POST /bookings - Book a ticket
  
  {
    "event_id": 1,
    "ticket_id": 2,
    "quantity": 1
  }

**Background Jobs (Sidekiq)**

1. Start Redis

  redis-server

2. Start Sidekiq

  bundle exec sidekiq

Jobs Implemented:
  
  BookingConfirmationJob - Sends booking confirmation email
  
  EventUpdateNotificationJob - Notifies customers if an event is updated
