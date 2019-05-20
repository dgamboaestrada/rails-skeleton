Rails.application.routes.draw do
  resources :roles, :path => 'api/v1/roles', :defaults => { :format => :json }
  resources :users, :path => 'api/v1/users', :defaults => { :format => :json }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
