Rails.application.routes.draw do
resources :perfumes
resources :personalities
root 'perfumes#index'
end