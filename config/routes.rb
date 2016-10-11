Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'facebooks/index', :via => [:get]
  match 'facebooks/login', :via => [:get]
  match 'facebooks/logout', :via => [:get]
  match 'facebooks/callback', :via => [:get]
  match 'facebooks/menu', :via => [:get]
  
  get 'facebooks/manage/:id', to: 'facebooks#manage', as: 'facebooks/manage'


  get 'facebooks/subscribe/:id', to: 'facebooks#subscribe', as: 'facebooks/subscribe'
  get 'facebooks/unsubscribe/:id', to: 'facebooks#unsubscribe', as: 'facebooks/unsubscribe'


  mount Facebook::Messenger::Server, at: 'bot'

  root :to => "facebooks#menu"
end
