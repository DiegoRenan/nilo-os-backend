Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  #http://guides.rubyonrails.org/routing.html
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :companies do
      
      resource :employees, only: [:show]
      resource :employees, only: [:show], path: 'relationships/employees'

      resource :tickets, only: [:show]
      resource :tickets, only: [:show], path: 'relationships/tickets' 
    end

    resources :tickets do
      resource :company, only: [:show]
      resource :company, only: [:show], path: 'relationships/company'
    end

    resources :employees do 
      resource :company, only: [:show]
      resource :company, only: [:show], path: 'relationships/company'
    end

  end
end
