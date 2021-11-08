class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       can :read, [News, Equipment, Specification]
       if user.is_role(Constants::DEPARTMENT)
         can [:read, :create, :update, :destroy, :load_request_to ], [ProcurementRequest, SpecificationRequest,
                                                                      TrainingRequest, InstallationRequest,
                                                                      MaintenanceRequest, CalibrationRequest,
                                                                      DisposalRequest]
         can :manage, [Receive]
         can :read, MaintenanceWorkOrder, user_id: user.id
         can :edit, MaintenanceWorkOrder, not_completed: true, user_id: user.id
       end
       if user.is_role(Constants::BIOMEDICAL_ENGINEER)
         can [:read, :create, :update, :destroy, :load_request_to ], [ProcurementRequest, SpecificationRequest,
                                                                      TrainingRequest, InstallationRequest,
                                                                      MaintenanceRequest, CalibrationRequest,
                                                                      DisposalRequest]
         can :manage, [Equipment, Receive, Issue, Maintenance, Training, Inventory, Disposal, SparePart]
         can :manage, News, organization_unit_id: user.organization_unit_id
         can :read, MaintenanceWorkOrder, user_id: user.id
         can :edit, MaintenanceWorkOrder, not_completed: true, user_id: user.id
         cannot :edit, Equipment
         can :edit, Equipment, organization_unit_id: user.organization_unit_id
         can :read, [Specification, ModelEquipmentList]
       end
       if user.is_role(Constants::BIOMEDICAL_HEAD)
         can [:read], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                 CalibrationRequest, DisposalRequest]
         can [:create], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                  CalibrationRequest, DisposalRequest] unless user.organization_unit == OrganizationUnit.top_organization_unit
         can :manage, [MaintenanceWorkOrder, Department]

         can [:decision], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                         CalibrationRequest, DisposalRequest] do |request|
           (request.organization_unit_id == user.organization_unit_id and request.status == Constants::PENDING) or (request.status == Constants::FORWARDED and request.forwards.order('created_at DESC').first.organization_unit_id == user.organization_unit_id rescue nil)
         end
         can [:manage, :decision], Forward, organization_unit_id: user.organization_unit_id
         can :manage, [Equipment, ModelEquipmentList, SparePart, OrganizationUnit, User, Store, Institution, EquipmentName, EquipmentType,
                       Receive, Issue, EquipmentStatus, MaintenanceWorkOrder, Maintenance, Training, Inventory, Disposal]

         cannot [:destroy,:edit], User
         can [:destroy, :edit], User, parent_unit: user.organization_unit_id
         can [:destroy, :edit], User if user.super_admin?
         cannot :edit, Equipment
         can :edit, Equipment, organization_unit_id: user.organization_unit_id

         can :read, [Department, Status, Specification, MaintenanceRequirement, OrganizationUnitType, Notification]
         can :manage, [Status, Specification, MaintenanceRequirement, OrganizationUnitType] if user.organization_unit == OrganizationUnit.top_organization_unit

         cannot [:edit, :update, :destroy], [Maintenance]
         can [:edit, :update, :destroy], [Maintenance], user_id: user.id
         can :manage, News, organization_unit_id: user.organization_unit_id
         can :edit, MaintenanceWorkOrder, not_completed: true
         cannot :manage, MaintenanceWorkOrder, status: Constants::COMPLETED
         can :manage, Contact, organization_unit_id: user.organization_unit_id
         can [:read, :create], Contact
         can :manage, [Specification, Setting] if user.super_admin?
         cannot :destroy, [:equipment, OrganizationUnit]
         can :destroy, [:equipment, OrganizationUnit] if user.super_admin?
         can :read, RequestStatus
       end

       if user.is_role(Constants::SUPPLIER)
         can :read, ProcurementRequest
         can :manage, RequestStatus
         can [:create, :read, :load_departments], User
         can :edit, User, institution_id: user.institution_id
         can :edit, Distribution
       end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
