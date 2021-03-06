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


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

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
    end

    get :default, to:'home#show'
    resource :verify
  end
end
