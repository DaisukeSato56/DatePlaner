Rails.application.routes.draw do
   root 'tweets#index'
   resources :tweets, only: [:create, :index, :destroy]

   get '/submit' => 'tweets#submit'
end
