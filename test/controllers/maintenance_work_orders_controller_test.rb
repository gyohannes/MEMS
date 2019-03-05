require 'test_helper'

class MaintenanceWorkOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance_work_order = maintenance_work_orders(:one)
  end

  test "should get index" do
    get maintenance_work_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_work_order_url
    assert_response :success
  end

  test "should create maintenance_work_order" do
    assert_difference('MaintenanceWorkOrder.count') do
      post maintenance_work_orders_url, params: { maintenance_work_order: { date: @maintenance_work_order.date, description_of_problem: @maintenance_work_order.description_of_problem, equipment_id: @maintenance_work_order.equipment_id, location: @maintenance_work_order.location, user_id: @maintenance_work_order.user_id } }
    end

    assert_redirected_to maintenance_work_order_url(MaintenanceWorkOrder.last)
  end

  test "should show maintenance_work_order" do
    get maintenance_work_order_url(@maintenance_work_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_work_order_url(@maintenance_work_order)
    assert_response :success
  end

  test "should update maintenance_work_order" do
    patch maintenance_work_order_url(@maintenance_work_order), params: { maintenance_work_order: { date: @maintenance_work_order.date, description_of_problem: @maintenance_work_order.description_of_problem, equipment_id: @maintenance_work_order.equipment_id, location: @maintenance_work_order.location, user_id: @maintenance_work_order.user_id } }
    assert_redirected_to maintenance_work_order_url(@maintenance_work_order)
  end

  test "should destroy maintenance_work_order" do
    assert_difference('MaintenanceWorkOrder.count', -1) do
      delete maintenance_work_order_url(@maintenance_work_order)
    end

    assert_redirected_to maintenance_work_orders_url
  end
end
