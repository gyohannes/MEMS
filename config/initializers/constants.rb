class Constants

  REQUEST_STATUSES = [PENDING = 'Pending', APPROVED = 'Approved', REJECTED = 'Rejected', DONE = 'Done', FORWARDED='Forwarded']

  REQUEST_TO = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                REPRESENTATIVE = 'Local Representative', SUPPLIER = 'Supplier', FACILITY = 'Health Facility']

  REQUEST = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                FACILITY = 'Health Facility']

  ORGANIZATION_TYPES = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                        ZHB = 'Zonal Health Bureau', WHB = 'Woreda Health Bureau']

  ROLES = [DEPARTMENT = 'Department Head', BIOMEDICAL_ENGINEER = 'Biomedical Engineer', BIOMEDICAL_HEAD = 'Biomedical Engineering Head']

  TRAINING_TYPES = [END_USER = 'End User Training', MAINTENANCE_PERSONNEL = 'Technical Personnel Training']

  ACTIONS = [ACCEPTED = 'Accepted', FORWARDED = 'Forwarded', OUT_SOURCED = 'Out Sourced', REJECTED='Rejected']

  EQUIPMENT_ACQUISITIONS = [PURCHASING='Purchasing',DONATION='Donation', LEASING_AND_RENTING='Leasing and Renting', \
CLUSTER_SHARING='Cluster Based Equipment Sharing', INNOVATION='Innovation, refubrished, local production and technology transfer']

  RISK_LEVELS = [HIGH_RISK='High Risk', MEDIUM_RISK='Medium Risk', LOW_RISK='Low Risk', HAZARD_SURVEILLANCE='Hazard Surveillance']

  ACCEPTANCE_TEST_RESULT = [ACCEPTED='Accepted', NOT_ACCEPTED='Not Accepted']

  WORK_ORDER_STATUS = [REQUEST_PENDING='Request Pending', WORK_ORDER_PENDING='Work Order Pending', COMPLETED='Work Order Completed', NOT_COMPLETED='Not Completed']

  STATUSES_AT_MAINTENANCE_REQUEST = [FUNCTIONAL='Functional', PARTIALLY_FUNCTIONAL='Partially Functional', NON_FUNCTIONAL='Non Functional']

  TRAINING_LEVELS = [BASIC='Basic', ADVANCED='Advanced', REFRESHMENT='Refreshment']

  MAINTENANCE_TYPES = [PREVENTIVE='Preventive Maintenance', CORRECTIVE='Corrective Maintenance']

  DISPOSAL_REASONS = [UNMAINTAINABLE='Unmaintainable', END_OF_SERVICE_YEAR='End of Service Year', NOT_NEEDED='No More Needed', OTHER = 'Other']

  DISPOSAL_METHODS = [SCRAP='Scrap', DONATE='Donate', OTHER = 'Other']
end