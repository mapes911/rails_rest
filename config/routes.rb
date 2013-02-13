RailsRest::Application.routes.draw do
  resources :users 
  resources :sessions, only: [:new, :create, :destroy]
  resources :experiences, only: [:index, :show, :create, :update, :destroy] do
    resources :chapters, only: [:index, :create, :update, :destroy]
  end

  root to: 'static_pages#home'



  #Last route in routes.rb - doesn't seem to work.. come back to this and figure out why later.
  match '*a', :to => 'errors#routing'
end
