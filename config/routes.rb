Rails.application.routes.draw do
  post '/graphql', to: 'graphql#create'

  get '*other', to: 'static#index'
end
