Rails.application.routes.draw do
resources :perfumes
resources :personalities
root 'perfumes#index'
get "types/:id", to: "types#show", as: :type
end