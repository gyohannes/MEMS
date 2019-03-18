class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       can :read, News
       if user.is_role(Constants::DEPARTMENT)
         can [:read, :create, :update, :destroy, :load_request_to ], [ProcurementRequest, SpecificationRequest,
                                                                      SparePartRequest, AcceptanceRequest,
                                                                      TrainingRequest, InstallationRequest,
                                                                      MaintenanceRequest, CalibrationRequest,
                                                                      DisposalRequest, BudgetRequest, MaintenanceToolkitRequest]
         can :manage, [Receive]
         can :read, MaintenanceWorkOrder, user_id: user.id
         can :edit, MaintenanceWorkOrder, not_completed: true, user_id: user.id
       end
       if user.is_role(Constants::BIOMEDICAL_ENGINEER)
         can [:read, :create, :update, :destroy, :load_request_to ], [ProcurementRequest, SpecificationRequest,
                                                                      SparePartRequest, AcceptanceRequest,
                                                                      TrainingRequest, InstallationRequest,
                                                                      MaintenanceRequest, CalibrationRequest,
                                                                      DisposalRequest, BudgetRequest, MaintenanceToolkitRequest]
         can :manage, [Equipment, Receive, Installation, AcceptanceTest, Maintenance, Training, Inventory, Disposal]
         can :manage, News, organization_structure_id: user.organization_structure_id
         can :read, MaintenanceWorkOrder, user_id: user.id
         can :edit, MaintenanceWorkOrder, not_completed: true, user_id: user.id
       end
       if user.is_role(Constants::BIOMEDICAL_HEAD)
         can [:read, :decision], [ProcurementRequest, SpecificationRequest, SparePartRequest,
                                  AcceptanceRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                  CalibrationRequest, DisposalRequest, BudgetRequest, MaintenanceToolkitRequest]
         can :manage, [OrganizationStructure, User, Department, FacilityType, Facility, Store, Institution, EquipmentCategory,
                       Equipment, Receive, MaintenanceWorkOrder, Installation, AcceptanceTest, Maintenance, Training, Inventory, Disposal]
         can :manage, News, organization_structure_id: user.organization_structure_id, facility_id: user.facility_id
         can :edit, MaintenanceWorkOrder, not_completed: true
         cannot :manage, MaintenanceWorkOrder, status: Constants::COMPLETED
         can :manage, Contact, organization_structure_id: user.organization_structure_id, facility_id: user.facility_id
         can [:read, :create], Contact
       end

       if user.is_role(Constants::SUPPLIER) || user.is_role(Constants::LOCAL_REPRESENTATIVE)
         can :manage, News, institution_id: user.institution_id
         can :manage, User, institution_id: user.institution_id
         can [:read, :decision], [ProcurementRequest, SpecificationRequest, SparePartRequest,
                                  AcceptanceRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                  CalibrationRequest, DisposalRequest, BudgetRequest, MaintenanceToolkitRequest]
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
