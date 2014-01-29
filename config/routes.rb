Activitiesapi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :activities
    end
  end
  post 'api/v1/bookings', to: "api/v1/bookings#create"
  post 'api/v1/recurrences', to: "api/v1/recurrences#create"
  delete 'api/v1/bookings/:id', to: "api/v1/bookings#destroy"
end

