Rails.application.routes.draw do
  resources :sub_distributions
  resources :equipment_issues do
    member do
      get 'confirm_delivery'
    end
  end
  get 'new_deliveries', to: 'equipment_issues#new_deliveries'
  resources :epsa_hubs
  resources :request_statuses do
    collection do
      get 'load_status'
    end
  end
  resources :epsa_statuses
  resources :epsa_teams
  resources :distributions do
    collection do
      get 'hub_allocations'
    end
  end
  resources :settings
  resources :forwards
  resources :statuses
  resources :maintenance_requirements
  resources :issues
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
  get 'reports/load_models'
  get 'reports/equipment'
  post 'reports/equipment'
  get 'reports/trainings'
  post 'reports/trainings'
  get 'reports/maintenances'
  post 'reports/maintenances'
  get 'reports/disposals'
  post 'reports/disposals'
  get 'reports/spare_parts'
  post 'reports/spare_parts'

  resources :news
  resources :inventories do
    collection do
      get 'load_facility_equipment'
    end
  end
  resources :specifications do
    collection do
      post 'import'
    end
  end
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
      patch 'decision'
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
      get 'import'
      post 'import'
    end
  end
  resources :equipment_names do
    collection do
      post 'import_names'
    end
  end
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
        get 'load_departments'
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
