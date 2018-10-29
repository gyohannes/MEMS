Rails.application.routes.draw do
  resources :maintenance_toolkit_requests
  resources :budget_requests
  resources :disposal_requests
  resources :calibration_requests
  resources :maintenance_requests
  resources :installation_requests
  resources :training_requests
  resources :acceptance_requests
  resources :spare_part_requests
  resources :specification_requests
  resources :trainings
  resources :contacts do
    collection do
      get 'load_contacts'
    end
  end
  resources :disposals
  resources :maintenances
  resources :acceptance_tests
  resources :installations
  resources :receives
  resources :stores
  resources :procurement_requests
  resources :equipment do
    collection do
      get 'load_equipment'
      get 'equipment_by_status'
      get 'equipment_by_category'
      get 'load_calendar'
    end
  end
  resources :equipment_names
  resources :equipment_categories
  resources :departments
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }
  scope "/admin" do
    resources :users do
      collection do
        get 'load_users'
      end
    end
  end
  resources :institutions do
    collection do
      get 'load_institutions'
    end
  end
  resources :facilities do
    collection do
      get 'load_facilities'
    end
  end
  resources :facility_types
  resources :organization_structures do
    collection do
      get 'load_tree'
      get 'load_facility_tree'
      get 'load_sub_units'
    end
  end
  resources :organization_structure_types
  resources :roles
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
