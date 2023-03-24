Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dealerships', to: 'dealerships#index'
  get 'dealerships/new', to: 'dealerships#new'
  get 'dealerships/:dealership_id/edit', to: 'dealerships#edit'
  get '/cars', to: 'cars#index'
  get '/dealerships/:dealership_id/cars', to: 'dealerships/cars#index'
  get '/cars/:id', to: 'cars#show'
  get '/dealerships/:id', to: 'dealerships#show'
  post '/dealerships', to: 'dealerships#create'
  patch '/dealerships/:dealership_id', to: 'dealerships#update'
end
