Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    get "/addresses", to: "addresses#search"
  end
end
