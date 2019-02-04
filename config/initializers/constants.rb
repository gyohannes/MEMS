class Constants

  REQUEST_STATUSES = [PENDING = 'Pending', APPROVED = 'Approved', REJECTED = 'Rejected', DONE = 'Done', FORWARDED='Forwarded']

  REQUEST_TO = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                REPRESENTATIVE = 'Local Representative', SUPPLIER = 'Supplier']

  REQUEST = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                FACILITY = 'Health Facility']

  ORGANIZATION_TYPES = [FMOH='Federal Ministry of Health', RHB='Regional Health Bureau',
                        ZHB = 'Zonal Health Bureau', WHB = 'Woreda Health Bureau']

  ROLES = [ADMIN = 'Administrator', DEPARTMENT = 'Department', BIOMEDICAL_ENGINEER = 'Biomedical Engineer', BIOMEDICAL_HEAD = 'Biomedical Head',
           SUPPLIER = 'Supplier', LOCAL_REPRESENTATIVE = 'Local Representative']

  TRAINING_TYPES = [END_USER = 'End User', MAINTENANCE_PERSONNEL = 'Maintenance Personnel']

  ACTIONS = [['Approve', APPROVED], ['Forward', FORWARDED], ['Reject', REJECTED]]

end