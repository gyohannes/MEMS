# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
org_unit_type = OrganizationUnitType.create(name: 'Ministry')
top_org_unit = OrganizationUnit.create(name: 'Ethiopian Federal Ministry of Health', code: 'FMOH',
                                       organization_unit_type_id: org_unit_type.id)

User.create(organization_unit_id: top_org_unit.id, first_name: 'Admin', father_name: 'Admin', grand_father_name: 'Admin', email: 'fmohhead@mems.com', password: 'admin123', role: Constants::BIOMEDICAL_HEAD)
Status.create(name: 'Disposed', static: true, color: '#FF0000')
AdminUser.create!(email: 'fmohhead@mems.com', password: 'admin123', password_confirmation: 'admin123')