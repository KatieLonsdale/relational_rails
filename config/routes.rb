Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dealerships', to: 'dealerships#index'
  get 'dealerships/new', to: 'dealerships#new'
  get 'dealerships/:dealership_id/edit', to: 'dealerships#edit'
  get 'dealerships/:dealership_id/cars/new', to: 'dealerships/cars#new'
  get 'dealerships/:dealership_id/cars/sort', to: 'dealerships/cars#index'
  get '/cars', to: 'cars#index'
  get '/cars/:id/edit', to: 'cars#edit'
  get '/dealerships/:dealership_id/cars', to: 'dealerships/cars#index'
  get '/cars/:id', to: 'cars#show'
  get '/dealerships/:id', to: 'dealerships#show'
  post '/dealerships', to: 'dealerships#create'
  post '/dealerships/:dealership_id/cars', to: 'dealerships/cars#create'
  patch '/dealerships/:dealership_id', to: 'dealerships#update'
  patch '/cars/:car_id', to: 'cars#update'
  delete '/dealerships/:dealership_id', to: 'dealerships#delete'
end
