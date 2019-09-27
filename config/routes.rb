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
    end

    resources :employees do 
      resource :company, only: [:show]
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
    
  end
end
