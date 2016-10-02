Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/edit_drive' => 'drive#new'
  get '/drive_redirect' => 'drive#create'

  resources :posts
  resources :cover_letters
end
