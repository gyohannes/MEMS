require 'test_helper'

class MaintenancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance = maintenances(:one)
  end

  test "should get index" do
    get maintenances_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_url
    assert_response :success
  end

  test "should create maintenance" do
    assert_difference('Maintenance.count') do
      post maintenances_url, params: { maintenance: { action_taken: @maintenance.action_taken, contact_address: @maintenance.contact_address, end_date: @maintenance.end_date, equipment_id: @maintenance.equipment_id, maintained_by: @maintenance.maintained_by, maintenance_cost: @maintenance.maintenance_cost, maintenance_type: @maintenance.maintenance_type, note: @maintenance.note, preventive_maintenance_date: @maintenance.preventive_maintenance_date, problem: @maintenance.problem, spare_parts_used: @maintenance.spare_parts_used, start_date: @maintenance.start_date } }
    end

    assert_redirected_to maintenance_url(Maintenance.last)
  end

  test "should show maintenance" do
    get maintenance_url(@maintenance)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_url(@maintenance)
    assert_response :success
  end

  test "should update maintenance" do
    patch maintenance_url(@maintenance), params: { maintenance: { action_taken: @maintenance.action_taken, contact_address: @maintenance.contact_address, end_date: @maintenance.end_date, equipment_id: @maintenance.equipment_id, maintained_by: @maintenance.maintained_by, maintenance_cost: @maintenance.maintenance_cost, maintenance_type: @maintenance.maintenance_type, note: @maintenance.note, preventive_maintenance_date: @maintenance.preventive_maintenance_date, problem: @maintenance.problem, spare_parts_used: @maintenance.spare_parts_used, start_date: @maintenance.start_date } }
    assert_redirected_to maintenance_url(@maintenance)
  end

  test "should destroy maintenance" do
    assert_difference('Maintenance.count', -1) do
      delete maintenance_url(@maintenance)
    end

    assert_redirected_to maintenances_url
  end
end
