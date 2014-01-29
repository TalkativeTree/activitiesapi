module Api
  module V1
    class RecurrencesController < ApplicationController
      before_filter :restrict_access

      def create
        begin
          @recurrence = Recurrence.build_from_activity params[:activity], params[:recurrence]
          render "api/v1/recurrences/create", status: 201
        rescue
          client_error
        end
      end

    end
  end
end
