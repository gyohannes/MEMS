# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180905142242) do

  create_table "acceptance_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "equipment_name"
    t.string "model"
    t.integer "volts_ampere"
    t.integer "power_requirement"
    t.text "description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_acceptance_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_acceptance_requests_on_organization_structure_id"
  end

  create_table "acceptance_tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "equipment_id"
    t.boolean "meet_standard"
    t.boolean "with_order_specification"
    t.boolean "installation_done"
    t.boolean "test_run"
    t.boolean "accepted"
    t.boolean "maintenance_personnel_trained"
    t.boolean "end_users_trained"
    t.boolean "with_full_accessery"
    t.boolean "with_manual"
    t.string "status"
    t.string "approved_by"
    t.date "acceptance_testing_date"
    t.string "contact_address"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_acceptance_tests_on_equipment_id"
  end

  create_table "budget_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "budget_name"
    t.text "budget_description"
    t.float "amount", limit: 24
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.text "contact_address"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_budget_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_budget_requests_on_organization_structure_id"
  end

  create_table "calibration_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.bigint "equipment_id"
    t.text "calibration_description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_calibration_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_calibration_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_calibration_requests_on_organization_structure_id"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "name_of_contact"
    t.string "profession"
    t.string "title"
    t.string "work_place"
    t.string "city"
    t.string "phone_number"
    t.string "country"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_contacts_on_facility_id"
    t.index ["organization_structure_id"], name: "index_contacts_on_organization_structure_id"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disposal_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.bigint "equipment_id"
    t.text "disposal_description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.text "contact_address"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_disposal_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_disposal_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_disposal_requests_on_organization_structure_id"
  end

  create_table "disposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "equipment_id"
    t.text "problem"
    t.text "action_taken"
    t.text "list_of_disposing_commitee"
    t.text "contact_address"
    t.date "disposed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_disposals_on_equipment_id"
  end

  create_table "equipment", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "facility_id"
    t.string "equipment_name"
    t.bigint "equipment_category_id"
    t.string "model"
    t.string "serial_number"
    t.string "tag_number"
    t.string "volt_ampere"
    t.integer "power_requirement"
    t.string "manufacturer"
    t.string "country"
    t.date "manufactured_year"
    t.date "purchased_year"
    t.float "purchase_price", limit: 24
    t.integer "supplier_id"
    t.boolean "manual_attached"
    t.text "warranty_agreement_note"
    t.integer "local_representative_id"
    t.text "remark"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_category_id"], name: "index_equipment_on_equipment_category_id"
    t.index ["facility_id"], name: "index_equipment_on_facility_id"
  end

  create_table "equipment_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "equipment_category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_category_id"], name: "index_equipment_names_on_equipment_category_id"
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.string "name"
    t.bigint "facility_type_id"
    t.string "category"
    t.string "url"
    t.integer "latitude"
    t.integer "longitude"
    t.integer "population"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_type_id"], name: "index_facilities_on_facility_type_id"
    t.index ["organization_structure_id"], name: "index_facilities_on_organization_structure_id"
  end

  create_table "facility_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installation_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "equipment_name"
    t.string "model"
    t.text "installation_description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_installation_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_installation_requests_on_organization_structure_id"
  end

  create_table "installations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "equipment_id"
    t.bigint "department_id"
    t.string "block_number"
    t.date "date_of_intallation"
    t.string "warranty_period"
    t.date "preventive_maintenance_date"
    t.string "installed_by"
    t.string "contact_address"
    t.float "installation_cost", limit: 24
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_installations_on_department_id"
    t.index ["equipment_id"], name: "index_installations_on_equipment_id"
  end

  create_table "institutions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.string "name"
    t.string "category"
    t.string "institution_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_structure_id"], name: "index_institutions_on_organization_structure_id"
  end

  create_table "maintenance_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.bigint "equipment_id"
    t.string "maintenance_type"
    t.text "maintenance_description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_maintenance_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_maintenance_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_maintenance_requests_on_organization_structure_id"
  end

  create_table "maintenance_toolkit_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "toolkit_name"
    t.text "toolkit_description"
    t.float "quantity", limit: 24
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.string "requested_by"
    t.text "contact_address"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_maintenance_toolkit_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_maintenance_toolkit_requests_on_organization_structure_id"
  end

  create_table "maintenances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "equipment_id"
    t.string "maintenance_type"
    t.text "problem"
    t.text "action_taken"
    t.text "spare_parts_used"
    t.date "start_date"
    t.date "end_date"
    t.float "maintenance_cost", limit: 24
    t.string "maintained_by"
    t.string "contact_address"
    t.date "preventive_maintenance_date"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_maintenances_on_equipment_id"
  end

  create_table "organization_structure_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.bigint "organization_structure_type_id"
    t.integer "parent_organization_structure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_structure_type_id"], name: "index_organization_structures_on_organization_structure_type_id"
  end

  create_table "procurement_request_equipments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "procurement_request_id"
    t.string "equipment_name"
    t.text "specification"
    t.integer "quantity"
    t.integer "approved_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procurement_request_id"], name: "index_procurement_request_equipments_on_procurement_request_id"
  end

  create_table "procurement_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.bigint "user_id"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "request_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_procurement_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_procurement_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_procurement_requests_on_user_id"
  end

  create_table "receive_equipments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "receive_id"
    t.string "equipment_name"
    t.string "model"
    t.text "description"
    t.integer "quantity"
    t.float "unit_cost", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_id"], name: "index_receive_equipments_on_receive_id"
  end

  create_table "receives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "store_id"
    t.string "deliverer_name"
    t.string "recipient_name"
    t.string "witness_name"
    t.date "delivery_date"
    t.text "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_receives_on_store_id"
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "spare_part_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "spare_part_name"
    t.string "model"
    t.integer "volts_ampere"
    t.integer "power_requirement"
    t.integer "quantity"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_spare_part_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_spare_part_requests_on_organization_structure_id"
  end

  create_table "specification_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "requested_to"
    t.integer "requested_to_org_structure"
    t.integer "requested_to_facility"
    t.integer "requested_to_institution"
    t.string "equipment_name"
    t.float "quantity", limit: 24
    t.string "requested_by"
    t.date "requested_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_specification_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_specification_requests_on_organization_structure_id"
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "store_name"
    t.string "block_number"
    t.string "room_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_stores_on_facility_id"
    t.index ["organization_structure_id"], name: "index_stores_on_organization_structure_id"
  end

  create_table "training_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.string "trainee_type"
    t.text "training_description"
    t.string "requested_to"
    t.integer "request_to_org_structure"
    t.integer "request_to_facility"
    t.integer "request_to_institution"
    t.string "requested_by"
    t.date "request_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_training_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_training_requests_on_organization_structure_id"
  end

  create_table "trainings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "contact_id"
    t.string "equipment_name"
    t.string "model"
    t.string "training_type"
    t.string "trainer_name"
    t.string "training_sponsor"
    t.date "training_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_trainings_on_contact_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "father_name"
    t.string "grand_father_name"
    t.bigint "organization_structure_id"
    t.bigint "facility_id"
    t.bigint "institution_id"
    t.string "user_type"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["facility_id"], name: "index_users_on_facility_id"
    t.index ["institution_id"], name: "index_users_on_institution_id"
    t.index ["organization_structure_id"], name: "index_users_on_organization_structure_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "acceptance_requests", "facilities"
  add_foreign_key "acceptance_requests", "organization_structures"
  add_foreign_key "acceptance_tests", "equipment"
  add_foreign_key "budget_requests", "facilities"
  add_foreign_key "budget_requests", "organization_structures"
  add_foreign_key "calibration_requests", "equipment"
  add_foreign_key "calibration_requests", "facilities"
  add_foreign_key "calibration_requests", "organization_structures"
  add_foreign_key "contacts", "facilities"
  add_foreign_key "contacts", "organization_structures"
  add_foreign_key "disposal_requests", "equipment"
  add_foreign_key "disposal_requests", "facilities"
  add_foreign_key "disposal_requests", "organization_structures"
  add_foreign_key "disposals", "equipment"
  add_foreign_key "equipment", "equipment_categories"
  add_foreign_key "equipment", "facilities"
  add_foreign_key "equipment_names", "equipment_categories"
  add_foreign_key "facilities", "facility_types"
  add_foreign_key "facilities", "organization_structures"
  add_foreign_key "installation_requests", "facilities"
  add_foreign_key "installation_requests", "organization_structures"
  add_foreign_key "installations", "departments"
  add_foreign_key "installations", "equipment"
  add_foreign_key "institutions", "organization_structures"
  add_foreign_key "maintenance_requests", "equipment"
  add_foreign_key "maintenance_requests", "facilities"
  add_foreign_key "maintenance_requests", "organization_structures"
  add_foreign_key "maintenance_toolkit_requests", "facilities"
  add_foreign_key "maintenance_toolkit_requests", "organization_structures"
  add_foreign_key "maintenances", "equipment"
  add_foreign_key "organization_structures", "organization_structure_types"
  add_foreign_key "procurement_request_equipments", "procurement_requests"
  add_foreign_key "procurement_requests", "facilities"
  add_foreign_key "procurement_requests", "organization_structures"
  add_foreign_key "procurement_requests", "users"
  add_foreign_key "receive_equipments", "receives", column: "receive_id"
  add_foreign_key "receives", "stores"
  add_foreign_key "spare_part_requests", "facilities"
  add_foreign_key "spare_part_requests", "organization_structures"
  add_foreign_key "specification_requests", "facilities"
  add_foreign_key "specification_requests", "organization_structures"
  add_foreign_key "stores", "facilities"
  add_foreign_key "stores", "organization_structures"
  add_foreign_key "training_requests", "facilities"
  add_foreign_key "training_requests", "organization_structures"
  add_foreign_key "trainings", "contacts"
  add_foreign_key "users", "facilities"
  add_foreign_key "users", "institutions"
  add_foreign_key "users", "organization_structures"
end
