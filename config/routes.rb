Rails.application.routes.draw do
  post '/', to: 'graphql#create'
end
