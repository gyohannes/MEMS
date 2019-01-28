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

ActiveRecord::Schema.define(version: 20190124210703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "acceptance_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "equipment_name"
    t.string "model"
    t.integer "volts_ampere"
    t.integer "power_requirement"
    t.text "description"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_acceptance_requests_on_facility_id"
    t.index ["institution_id"], name: "index_acceptance_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_acceptance_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_acceptance_requests_on_user_id"
  end

  create_table "acceptance_tests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_id"
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

  create_table "budget_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "budget_name"
    t.text "budget_description"
    t.float "amount"
    t.string "request_to"
    t.text "contact_address"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_budget_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_budget_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_budget_requests_on_user_id"
  end

  create_table "calibration_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "equipment_id"
    t.uuid "user_id"
    t.text "calibration_description"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_calibration_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_calibration_requests_on_facility_id"
    t.index ["institution_id"], name: "index_calibration_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_calibration_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_calibration_requests_on_user_id"
  end

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
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

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disposal_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "equipment_id"
    t.uuid "user_id"
    t.text "disposal_description"
    t.string "request_to"
    t.text "contact_address"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_disposal_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_disposal_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_disposal_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_disposal_requests_on_user_id"
  end

  create_table "disposals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_id"
    t.text "problem"
    t.text "action_taken"
    t.text "list_of_disposing_commitee"
    t.text "contact_address"
    t.date "disposed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_disposals_on_equipment_id"
  end

  create_table "equipment", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "facility_id"
    t.string "equipment_name"
    t.uuid "equipment_category_id"
    t.string "model"
    t.string "serial_number"
    t.string "tag_number"
    t.string "volt_ampere"
    t.integer "power_requirement"
    t.string "manufacturer"
    t.string "country"
    t.date "manufactured_year"
    t.integer "life_span"
    t.date "purchased_year"
    t.float "use_of_years"
    t.float "purchase_price"
    t.date "date_of_installation"
    t.integer "supplier_id"
    t.boolean "manual_attached"
    t.text "warranty_agreement_note"
    t.integer "local_representative_id"
    t.text "remark"
    t.string "status"
    t.boolean "trained_end_users"
    t.boolean "trained_maintenance_personnel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_category_id"], name: "index_equipment_on_equipment_category_id"
    t.index ["facility_id"], name: "index_equipment_on_facility_id"
  end

  create_table "equipment_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment_names", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_category_id"], name: "index_equipment_names_on_equipment_category_id"
  end

  create_table "facilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.string "name"
    t.uuid "facility_type_id"
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

  create_table "facility_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installation_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "equipment_name"
    t.string "model"
    t.text "installation_description"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_installation_requests_on_facility_id"
    t.index ["institution_id"], name: "index_installation_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_installation_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_installation_requests_on_user_id"
  end

  create_table "installations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_id"
    t.uuid "department_id"
    t.string "block_number"
    t.date "date_of_installation"
    t.string "warranty_period"
    t.date "preventive_maintenance_date"
    t.string "installed_by"
    t.string "contact_address"
    t.float "installation_cost"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_installations_on_department_id"
    t.index ["equipment_id"], name: "index_installations_on_equipment_id"
  end

  create_table "institutions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.string "name"
    t.string "category"
    t.string "institution_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_structure_id"], name: "index_institutions_on_organization_structure_id"
  end

  create_table "inventories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_id"
    t.string "status"
    t.text "description_of_problem"
    t.boolean "trained_end_users"
    t.boolean "trained_maintenance_personnel"
    t.text "suggestion"
    t.string "risk_level"
    t.date "inventory_date"
    t.string "inventory_done_by"
    t.text "contact_address"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_inventories_on_equipment_id"
  end

  create_table "maintenance_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "equipment_id"
    t.uuid "user_id"
    t.string "maintenance_type"
    t.text "maintenance_description"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_maintenance_requests_on_equipment_id"
    t.index ["facility_id"], name: "index_maintenance_requests_on_facility_id"
    t.index ["institution_id"], name: "index_maintenance_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_maintenance_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_maintenance_requests_on_user_id"
  end

  create_table "maintenance_toolkit_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "toolkit_name"
    t.text "toolkit_description"
    t.float "quantity"
    t.string "request_to"
    t.text "contact_address"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_maintenance_toolkit_requests_on_facility_id"
    t.index ["organization_structure_id"], name: "index_maintenance_toolkit_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_maintenance_toolkit_requests_on_user_id"
  end

  create_table "maintenances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "equipment_id"
    t.string "maintenance_type"
    t.text "problem"
    t.text "action_taken"
    t.text "spare_parts_used"
    t.date "start_date"
    t.date "end_date"
    t.float "maintenance_cost"
    t.string "maintained_by"
    t.string "contact_address"
    t.date "preventive_maintenance_date"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_maintenances_on_equipment_id"
  end

  create_table "organization_structure_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_structures", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "organization_structure_type"
    t.string "parent_organization_structure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procurement_request_equipments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "procurement_request_id"
    t.string "equipment_name"
    t.text "specification"
    t.integer "quantity"
    t.integer "approved_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procurement_request_id"], name: "index_procurement_request_equipments_on_procurement_request_id"
  end

  create_table "procurement_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_procurement_requests_on_facility_id"
    t.index ["institution_id"], name: "index_procurement_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_procurement_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_procurement_requests_on_user_id"
  end

  create_table "receive_equipments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "receive_id"
    t.string "equipment_name"
    t.string "model"
    t.text "description"
    t.integer "quantity"
    t.float "unit_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_id"], name: "index_receive_equipments_on_receive_id"
  end

  create_table "receives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id"
    t.string "been_number"
    t.string "equipment_name"
    t.string "model"
    t.string "deliverer_name"
    t.string "recipient_name"
    t.text "recipient_contact_address"
    t.boolean "with_full_checklist"
    t.string "witness_name"
    t.string "witness_contact_address"
    t.integer "quantity"
    t.float "unit_cost"
    t.date "delivery_date"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_receives_on_store_id"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spare_part_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "spare_part_name"
    t.string "model"
    t.integer "volts_ampere"
    t.integer "power_requirement"
    t.integer "quantity"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_spare_part_requests_on_facility_id"
    t.index ["institution_id"], name: "index_spare_part_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_spare_part_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_spare_part_requests_on_user_id"
  end

  create_table "specification_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "request_to"
    t.uuid "institution_id"
    t.string "equipment_name"
    t.float "quantity"
    t.date "requested_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_specification_requests_on_facility_id"
    t.index ["institution_id"], name: "index_specification_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_specification_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_specification_requests_on_user_id"
  end

  create_table "specifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.string "equipment_name"
    t.string "model"
    t.text "description"
    t.string "approximate_cost"
    t.string "specification_by"
    t.string "contact_address"
    t.date "specification_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["facility_id"], name: "index_specifications_on_facility_id"
    t.index ["organization_structure_id"], name: "index_specifications_on_organization_structure_id"
  end

  create_table "store_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id"
    t.string "been_number"
    t.uuid "equipment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_store_registrations_on_equipment_id"
    t.index ["store_id"], name: "index_store_registrations_on_store_id"
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.string "store_name"
    t.string "block_number"
    t.string "room_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_stores_on_facility_id"
    t.index ["organization_structure_id"], name: "index_stores_on_organization_structure_id"
  end

  create_table "training_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "user_id"
    t.string "trainee_type"
    t.text "training_description"
    t.string "request_to"
    t.uuid "institution_id"
    t.date "request_date"
    t.text "comment"
    t.string "decision_by"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_training_requests_on_facility_id"
    t.index ["institution_id"], name: "index_training_requests_on_institution_id"
    t.index ["organization_structure_id"], name: "index_training_requests_on_organization_structure_id"
    t.index ["user_id"], name: "index_training_requests_on_user_id"
  end

  create_table "trainings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contact_id"
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

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "father_name"
    t.string "grand_father_name"
    t.uuid "organization_structure_id"
    t.uuid "facility_id"
    t.uuid "institution_id"
    t.uuid "department_id"
    t.uuid "store_id"
    t.string "role"
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
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["facility_id"], name: "index_users_on_facility_id"
    t.index ["institution_id"], name: "index_users_on_institution_id"
    t.index ["organization_structure_id"], name: "index_users_on_organization_structure_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["store_id"], name: "index_users_on_store_id"
  end

  add_foreign_key "acceptance_requests", "facilities"
  add_foreign_key "acceptance_requests", "institutions"
  add_foreign_key "acceptance_requests", "organization_structures"
  add_foreign_key "acceptance_requests", "users"
  add_foreign_key "acceptance_tests", "equipment"
  add_foreign_key "budget_requests", "facilities"
  add_foreign_key "budget_requests", "organization_structures"
  add_foreign_key "budget_requests", "users"
  add_foreign_key "calibration_requests", "equipment"
  add_foreign_key "calibration_requests", "facilities"
  add_foreign_key "calibration_requests", "institutions"
  add_foreign_key "calibration_requests", "organization_structures"
  add_foreign_key "calibration_requests", "users"
  add_foreign_key "contacts", "facilities"
  add_foreign_key "contacts", "organization_structures"
  add_foreign_key "disposal_requests", "equipment"
  add_foreign_key "disposal_requests", "facilities"
  add_foreign_key "disposal_requests", "organization_structures"
  add_foreign_key "disposal_requests", "users"
  add_foreign_key "disposals", "equipment"
  add_foreign_key "equipment", "equipment_categories"
  add_foreign_key "equipment", "facilities"
  add_foreign_key "equipment_names", "equipment_categories"
  add_foreign_key "facilities", "facility_types"
  add_foreign_key "facilities", "organization_structures"
  add_foreign_key "installation_requests", "facilities"
  add_foreign_key "installation_requests", "institutions"
  add_foreign_key "installation_requests", "organization_structures"
  add_foreign_key "installation_requests", "users"
  add_foreign_key "installations", "departments"
  add_foreign_key "installations", "equipment"
  add_foreign_key "institutions", "organization_structures"
  add_foreign_key "inventories", "equipment"
  add_foreign_key "maintenance_requests", "equipment"
  add_foreign_key "maintenance_requests", "facilities"
  add_foreign_key "maintenance_requests", "institutions"
  add_foreign_key "maintenance_requests", "organization_structures"
  add_foreign_key "maintenance_requests", "users"
  add_foreign_key "maintenance_toolkit_requests", "facilities"
  add_foreign_key "maintenance_toolkit_requests", "organization_structures"
  add_foreign_key "maintenance_toolkit_requests", "users"
  add_foreign_key "maintenances", "equipment"
  add_foreign_key "procurement_request_equipments", "procurement_requests"
  add_foreign_key "procurement_requests", "facilities"
  add_foreign_key "procurement_requests", "institutions"
  add_foreign_key "procurement_requests", "organization_structures"
  add_foreign_key "procurement_requests", "users"
  add_foreign_key "receive_equipments", "receives", column: "receive_id"
  add_foreign_key "receives", "stores"
  add_foreign_key "spare_part_requests", "facilities"
  add_foreign_key "spare_part_requests", "institutions"
  add_foreign_key "spare_part_requests", "organization_structures"
  add_foreign_key "spare_part_requests", "users"
  add_foreign_key "specification_requests", "facilities"
  add_foreign_key "specification_requests", "institutions"
  add_foreign_key "specification_requests", "organization_structures"
  add_foreign_key "specification_requests", "users"
  add_foreign_key "specifications", "facilities"
  add_foreign_key "specifications", "organization_structures"
  add_foreign_key "store_registrations", "equipment"
  add_foreign_key "store_registrations", "stores"
  add_foreign_key "stores", "facilities"
  add_foreign_key "stores", "organization_structures"
  add_foreign_key "training_requests", "facilities"
  add_foreign_key "training_requests", "institutions"
  add_foreign_key "training_requests", "organization_structures"
  add_foreign_key "training_requests", "users"
  add_foreign_key "trainings", "contacts"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "facilities"
  add_foreign_key "users", "institutions"
  add_foreign_key "users", "organization_structures"
  add_foreign_key "users", "stores"
end
