Rails.application.routes.draw do
  resources :statuses
  resources :maintenance_requirements
  resources :issues
  resources :planned_preventive_maintenaces
  resources :notifications
  resources :spare_parts do
    collection do
      get 'ideal_vs_available_by_type'
    end
  end
  resources :model_equipment_list
  resources :equipment_types
  resources :equipment_statuses
  resources :maintenance_work_orders
  get 'reports/equipment'
  post 'reports/equipment'
  get 'reports/load_facilities'
  get 'reports/trainings'
  post 'reports/trainings'

  resources :news
  resources :inventories
  resources :specifications
  resources :store_registrations
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
      get 'forward'
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
      get 'search'
      get 'load_contacts'
    end
  end
  resources :disposals
  resources :maintenances do
    collection do
      get 'load_maintenance_requests'
    end
  end
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
      get 'search'
      get 'facility_equipment_search'
      get 'load_equipment'
      get 'equipment_by_status'
      get 'equipment_by_type'
      get 'equipment_by_department'
      get 'equipment_by_org_unit_and_status'
      get 'equipment_by_org_unit_and_type'
      get 'ideal_vs_available_by_type'
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
  resources :organization_units do
    collection do
      get 'load_tree'
      get 'load_all_tree'
      get 'load_facility_tree'
      get 'load_sub_units'
    end
  end
  resources :organization_unit_types
  resources :roles
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
