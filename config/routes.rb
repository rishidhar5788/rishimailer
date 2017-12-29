Rails.application.routes.draw do
  post '/sendemail', to: 'email#sendemail'
end
