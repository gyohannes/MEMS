class Constants

  REQUEST_STATUSES = [PENDING = 'Pending', APPROVED = 'Approved', REJECTED = 'Rejected', DONE = 'Done', FORWARDED='Forwarded']

  REQUEST_TO = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                REPRESENTATIVE = 'Local Representative', SUPPLIER = 'Supplier', FACILITY = 'Health Facility']

  REQUEST = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                FACILITY = 'Health Facility']

  ORGANIZATION_TYPES = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                        ZHB = 'Zonal Health Bureau', WHB = 'Woreda Health Bureau']

  ROLES = [DEPARTMENT = 'Department', BIOMEDICAL_ENGINEER = 'Biomedical Engineer', BIOMEDICAL_HEAD = 'Biomedical Head',
           SUPPLIER = 'Supplier', LOCAL_REPRESENTATIVE = 'Local Representative']

  TRAINING_TYPES = [END_USER = 'End User', MAINTENANCE_PERSONNEL = 'Maintenance Personnel']

  ACTIONS = [['Approve', APPROVED], ['Forward', FORWARDED], ['Reject', REJECTED]]

  EQUIPMENT_ACQUISITIONS = [PURCHASING='Purchasing',DONATION='Donation', LEASING_AND_RENTING='Leasing and Renting', \
CLUSTER_SHARING='Cluster Based Equipment Sharing', INNOVATION='Innovation, refubrished, local production and technology transfer']

  RISK_LEVELS = [HIGH_RISK='High Risk', MEDIUM_RISK='Medium Risk', LOW_RISK='Low Risk', HAZARD_SURVEILLANCE='Hazard Surveillance']

  ACCEPTANCE_TEST_RESULT = [ACCEPTED='Accepted', NOT_ACCEPTED='Not Accepted']

  WORK_ORDER_STATUS = [PENDING='Pending', COMPLETED='Completed', NOT_COMPLETED='Not Completed']

end