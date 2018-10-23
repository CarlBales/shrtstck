Rails.application.routes.draw do
  resources :shortened_links
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shortened_links#new'
  get "/s/:short_url_slug", action: :shortened, controller: 'shortened_links'
  
  scope '/admin' do
    resources :shortened_links, only: [:index, :update]
  end

  resources :shortened_links do
    member do
      patch :toggle_expire_link_status
    end
  end
end
