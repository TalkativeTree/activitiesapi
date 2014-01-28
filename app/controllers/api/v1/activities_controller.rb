module Api
  module V1
    class ActivitiesController < ApplicationController
      before_filter :restrict_access, except: [:index, :show]
      include ActionController::ImplicitRender

      def show
        @activity = Activity.find_by_id(params[:id])
      end

      def index
        @activities = Activity.all
      end

      def create
        activity = params[:activity]
        @activity = Activity.build_from_json activity
        if @activity.save
          render 'api/v1/activities/show', status: 201
        else
          client_error
        end
      end

      def update
        activity = params[:activity]
        if Activity.update_from_json! params[:id], activity
          render status: 200
        else
          client_error
        end
      end

      def destroy
        activity = Activity.find_by_id params[:id]
        if activity.destroy
          render status: 200
        else
          client_error
        end
      end

      private

      def restrict_access
        unless params[:token].present? && params[:token] == "12345"
          render status: 401
        end
      end

      def client_error
        render status: 400 
      end

    end
  end
end
