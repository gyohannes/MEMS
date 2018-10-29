require 'test_helper'

class MaintenanceToolkitRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance_toolkit_request = maintenance_toolkit_requests(:one)
  end

  test "should get index" do
    get maintenance_toolkit_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_toolkit_request_url
    assert_response :success
  end

  test "should create maintenance_toolkit_request" do
    assert_difference('MaintenanceToolkitRequest.count') do
      post maintenance_toolkit_requests_url, params: { maintenance_toolkit_request: { contact_address: @maintenance_toolkit_request.contact_address, facility_id: @maintenance_toolkit_request.facility_id, organization_structure_id: @maintenance_toolkit_request.organization_structure_id, quantity: @maintenance_toolkit_request.quantity, request_date: @maintenance_toolkit_request.request_date, request_to_facility: @maintenance_toolkit_request.request_to_facility, request_to_org_structure: @maintenance_toolkit_request.request_to_org_structure, requested_by: @maintenance_toolkit_request.requested_by, requested_to: @maintenance_toolkit_request.requested_to, toolkit_description: @maintenance_toolkit_request.toolkit_description, toolkit_name: @maintenance_toolkit_request.toolkit_name } }
    end

    assert_redirected_to maintenance_toolkit_request_url(MaintenanceToolkitRequest.last)
  end

  test "should show maintenance_toolkit_request" do
    get maintenance_toolkit_request_url(@maintenance_toolkit_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_toolkit_request_url(@maintenance_toolkit_request)
    assert_response :success
  end

  test "should update maintenance_toolkit_request" do
    patch maintenance_toolkit_request_url(@maintenance_toolkit_request), params: { maintenance_toolkit_request: { contact_address: @maintenance_toolkit_request.contact_address, facility_id: @maintenance_toolkit_request.facility_id, organization_structure_id: @maintenance_toolkit_request.organization_structure_id, quantity: @maintenance_toolkit_request.quantity, request_date: @maintenance_toolkit_request.request_date, request_to_facility: @maintenance_toolkit_request.request_to_facility, request_to_org_structure: @maintenance_toolkit_request.request_to_org_structure, requested_by: @maintenance_toolkit_request.requested_by, requested_to: @maintenance_toolkit_request.requested_to, toolkit_description: @maintenance_toolkit_request.toolkit_description, toolkit_name: @maintenance_toolkit_request.toolkit_name } }
    assert_redirected_to maintenance_toolkit_request_url(@maintenance_toolkit_request)
  end

  test "should destroy maintenance_toolkit_request" do
    assert_difference('MaintenanceToolkitRequest.count', -1) do
      delete maintenance_toolkit_request_url(@maintenance_toolkit_request)
    end

    assert_redirected_to maintenance_toolkit_requests_url
  end
end
