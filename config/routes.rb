Rails.application.routes.draw do

  resources :events do
  	member do
  		get 'start'
  		get 'stop'
  	end
  end
  resources :event_results, :only => [:edit, :update, :destroy] do
  	member do
  		get "start"
  		get "stop"
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "events#index"
end
