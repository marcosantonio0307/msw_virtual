Rails.application.routes.draw do
  devise_for :users
  namespace :api do
  	namespace :v1 do
  	  resources :products, only:[:index, :new, :create, :edit, :upgrade, :show, :destroy]
  	end
  end

end
