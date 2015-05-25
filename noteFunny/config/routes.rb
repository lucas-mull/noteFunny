Rails.application.routes.draw do

  # ROOT
  root 'utilisateurs#index'

  # UtilisateursController
  resources :utilisateurs
  post 'connexion' => 'utilisateurs#login'
  get 'deconnexion' => 'utilisateurs#logout'
  get 'changePassword' => 'utilisateurs#change_password'
  post 'submitNewPassword' => 'utilisateurs#submit_password_change'
  get '/list' => 'utilisateurs#list', :as => 'utilisateurs_list'
  get 'confirm/:id' => 'utilisateurs#confirm', :as => 'utilisateurs_confirm'
  get 'confirm_admin/:id' => 'utilisateurs#confirm_admin'
  get 'enseignants' => 'utilisateur#index'
  get 'etudiants' => 'utilisateurs#index'

  # MatieresController
  resources :matieres
  get 'add_etu' => 'matieres#add_student'
  post 'submit_etu' => 'matieres#submit_student'

  # AppartenancesController
  get 'sendConfirmEmail' => 'appartenances#invite'
  post 'appartenances/createList' => 'appartenances#createList'

  # EpreuvesController
  resources :epreuves
  get 'matieres/:matiere_id/epreuves' => 'epreuves#index_by', :as => 'epreuves_by_matiere'
  post 'epreuves/set_matiere' => 'epreuves#set_matiere'

  # ResultatsController
  get 'resultats/create' => 'resultats#create'
  get 'epreuves/:epreuve_id/resultats' => 'resultats#show', :as => 'resultats_show'
  post 'resultats/update' => 'resultats#update', :as => 'resultats_update'
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
