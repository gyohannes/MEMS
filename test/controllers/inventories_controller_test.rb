require 'test_helper'

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory = inventories(:one)
  end

  test "should get index" do
    get inventories_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_url
    assert_response :success
  end

  test "should create inventory" do
    assert_difference('Inventory.count') do
      post inventories_url, params: { inventory: { contact_address: @inventory.contact_address, description_of_problem: @inventory.description_of_problem, equipment_id: @inventory.equipment_id, inventory_date: @inventory.inventory_date, inventory_done_by: @inventory.inventory_done_by, note: @inventory.note, risk_level: @inventory.risk_level, status: @inventory.status, suggestion: @inventory.suggestion, trained_end_users: @inventory.trained_end_users, trained_maintenance_personnel: @inventory.trained_maintenance_personnel } }
    end

    assert_redirected_to inventory_url(Inventory.last)
  end

  test "should show inventory" do
    get inventory_url(@inventory)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_url(@inventory)
    assert_response :success
  end

  test "should update inventory" do
    patch inventory_url(@inventory), params: { inventory: { contact_address: @inventory.contact_address, description_of_problem: @inventory.description_of_problem, equipment_id: @inventory.equipment_id, inventory_date: @inventory.inventory_date, inventory_done_by: @inventory.inventory_done_by, note: @inventory.note, risk_level: @inventory.risk_level, status: @inventory.status, suggestion: @inventory.suggestion, trained_end_users: @inventory.trained_end_users, trained_maintenance_personnel: @inventory.trained_maintenance_personnel } }
    assert_redirected_to inventory_url(@inventory)
  end

  test "should destroy inventory" do
    assert_difference('Inventory.count', -1) do
      delete inventory_url(@inventory)
    end

    assert_redirected_to inventories_url
  end
end
