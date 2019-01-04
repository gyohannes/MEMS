# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
role = Role.create(name: 'Admin')

top_org_unit = OrganizationStructure.create(name: 'Ethiopian Federal Ministry of Health', code: 'FMOH',
                                            organization_structure_type: Constants::FMOH)

admin_user = User.new(organization_structure_id: top_org_unit.id,email: 'admin@mems.com', password: 'admin123')
admin_user.role = role
admin_user.save
