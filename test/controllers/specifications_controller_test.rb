require 'test_helper'

class SpecificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @specification = specifications(:one)
  end

  test "should get index" do
    get specifications_url
    assert_response :success
  end

  test "should get new" do
    get new_specification_url
    assert_response :success
  end

  test "should create specification" do
    assert_difference('Specification.count') do
      post specifications_url, params: { specification: { approximate_cost: @specification.approximate_cost, contact_address: @specification.contact_address, description: @specification.description, equipment_name: @specification.equipment_name, facility_id: @specification.facility_id, model: @specification.model, organization_structure_id: @specification.organization_structure_id, specification_by: @specification.specification_by, specification_date: @specification.specification_date } }
    end

    assert_redirected_to specification_url(Specification.last)
  end

  test "should show specification" do
    get specification_url(@specification)
    assert_response :success
  end

  test "should get edit" do
    get edit_specification_url(@specification)
    assert_response :success
  end

  test "should update specification" do
    patch specification_url(@specification), params: { specification: { approximate_cost: @specification.approximate_cost, contact_address: @specification.contact_address, description: @specification.description, equipment_name: @specification.equipment_name, facility_id: @specification.facility_id, model: @specification.model, organization_structure_id: @specification.organization_structure_id, specification_by: @specification.specification_by, specification_date: @specification.specification_date } }
    assert_redirected_to specification_url(@specification)
  end

  test "should destroy specification" do
    assert_difference('Specification.count', -1) do
      delete specification_url(@specification)
    end

    assert_redirected_to specifications_url
  end
end
