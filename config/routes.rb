Rails.application.routes.draw do
  resources :exectests
  resources :steps
  resources :testes
  resources :suites
  resources :qas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
