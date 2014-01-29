module Api
  module V1
    class ActivitiesController < ApplicationController
      before_filter :restrict_access, except: [:index, :show]
      include ActionController::ImplicitRender

      def show
        @activity = Activity.find_by_id(params[:id])
      end

      def index
        if params[:query] == "true"
          @activities = Activity.query_by params 
          if @activities
            render 'api/v1/activities/index', status: 201
          else
            render 'api/v1/activities/index', status: 206
          end
        else
          @activities = Activity.all
        end
      end

      def create
        @activity = Activity.build_from_json params[:activity]
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

    end
  end
end
