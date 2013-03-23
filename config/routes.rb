Caninae::Application.routes.draw do
  resources :people
  resources :animal_kennels
  resources :animal_owners
  resources :succeeds
  resources :preceeds
  resources :dominates
  resources :titles
  resources :achievements
  resources :certifications
  resources :offspring_litters
  resources :litters
  resources :kennel_litters
  resources :person_kennels
  resources :kennels
  resources :registrations
  resources :animal_breeders
  resources :clearances
  resources :animals
  resources :events
  resources :locations

  namespace :tollerdata do
    get '/', :to => 'home#show'

    get :home, to:'home#show'
    get :about, to:'home#about'

    resources :animals do
      resources :siblings
      resources :offspring
      resources :pedigree do
        get :hip, to:'pedigree#hip'
        get :longevity, to:'pedigree#longevity'
      end
      resource :image
      resource :health do
        resources :categories, to:"health/categories"
      end
      resources :clearances do
        post :get
      end
    end

    get :default, to:'home#show'
    resource :verify
  end
end
