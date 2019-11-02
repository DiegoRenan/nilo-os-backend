Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  #http://guides.rubyonrails.org/routing.html
  
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :companies do
      resource :employees, only: [:show]
      resource :tickets, only: [:show]
      resource :departments, only: [:show]
    end

    resources :tickets do
      resource :company, only: [:show]
      resource :comments, only: [:show]
      resource :responsibles, only: [:show]
    end

    post '/close_ticket', to: 'tickets#close'
    post '/aprove_ticket', to: 'tickets#aprove'

    resources :employees do
      resources :avatar, only: [:show, :create] 
      resource :company, only: [:show]
      resource :comments, only: [:show]
      resource :tickets, only: [:show]
    end

    resources :departments do 
      resource :company, only: [:show]
      resource :sectors, only: [:show]
    end

    resources :sectors do
      resource :department, only: [:show]
    end

    resources :ticket_statuses

    resources :ticket_types

    resources :comments

    resources :priorities, only: [:index]
    
    resources :responsibles, only: [:destroy, :create]
  end
end
