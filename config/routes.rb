Rails.application.routes.draw do
  resources :maintenance_toolkit_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :budget_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :disposal_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :calibration_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :maintenance_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :installation_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :training_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :acceptance_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :spare_part_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
  resources :specification_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
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
  resources :procurement_requests do
    member do
      patch 'decision'
    end
    collection do
      get 'load_request_to'
    end
  end
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
