module Api
  module V1
    class BookingsController < ApplicationController
      before_filter :restrict_access

      def create
        booking = Booking.build_from_json params[:booking]
        if booking.save
          render status: 201
        else
          client_error
        end
      end

    end
  end
end
