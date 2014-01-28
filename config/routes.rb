Activitiesapi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :activities
    end
  end
end

