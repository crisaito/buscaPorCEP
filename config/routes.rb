Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    get "/addresses/:cep", to: "addresses#search", as: "addresses"
  end
end
