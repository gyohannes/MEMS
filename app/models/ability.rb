class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       can :read, News
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
         can :manage, [Equipment, Receive, Maintenance, Training, Inventory, Disposal]
         can :manage, News, organization_unit_id: user.organization_unit_id
         can :read, MaintenanceWorkOrder, user_id: user.id
         can :edit, MaintenanceWorkOrder, not_completed: true, user_id: user.id
         cannot :edit, Equipment
         cannot :edit, Equipment, status_id: Status.disposed_status
       end
       if user.is_role(Constants::BIOMEDICAL_HEAD)
         can [:read,:create], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                 CalibrationRequest, DisposalRequest]
         can [:edit, :destroy], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                  CalibrationRequest, DisposalRequest]
         can [:manage, :decision], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                         CalibrationRequest, DisposalRequest], organization_unit_id: user.organization_unit_id
         can :manage, [OrganizationUnit, User, Department, Store, Institution, EquipmentStatus,
                       Equipment, Receive, MaintenanceWorkOrder, Maintenance, Training, Inventory, Disposal]
         cannot [:edit, :update, :destroy], [Maintenance]
         can [:edit, :update, :destroy], [Maintenance], user_id: user.id
         can :manage, News, organization_unit_id: user.organization_unit_id
         can :edit, MaintenanceWorkOrder, not_completed: true
         cannot :manage, MaintenanceWorkOrder, status: Constants::COMPLETED
         can :manage, Contact, organization_unit_id: user.organization_unit_id
         can [:read, :create], Contact
         can :manage, [Specification] if user.super_admin?
         cannot :edit, Equipment, status_id: Status.disposed_status
       end

       if user.is_role(Constants::SUPPLIER) || user.is_role(Constants::LOCAL_REPRESENTATIVE)
         can :manage, News, institution_id: user.institution_id
         can :manage, User, institution_id: user.institution_id
         can [:read, :decision], [ProcurementRequest, SpecificationRequest, TrainingRequest, InstallationRequest, MaintenanceRequest,
                                  CalibrationRequest, DisposalRequest]
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
