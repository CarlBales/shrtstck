Rails.application.routes.draw do
  resources :shortened_links
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  get "/s/:short_url_slug", action: :shortened, controller: 'shortened_links'
  # get "/s/:short_url_slug", to: "shotened_links#show",  as: :shortened_link
  # resources :urls, only: :create

end
