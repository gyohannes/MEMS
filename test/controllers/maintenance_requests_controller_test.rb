require 'test_helper'

class MaintenanceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance_request = maintenance_requests(:one)
  end

  test "should get index" do
    get maintenance_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_request_url
    assert_response :success
  end

  test "should create maintenance_request" do
    assert_difference('MaintenanceRequest.count') do
      post maintenance_requests_url, params: { maintenance_request: { equipment_id: @maintenance_request.equipment_id, facility_id: @maintenance_request.facility_id, maintenance_description: @maintenance_request.maintenance_description, maintenance_type: @maintenance_request.maintenance_type, organization_structure_id: @maintenance_request.organization_structure_id, request_date: @maintenance_request.request_date, request_to_facility: @maintenance_request.request_to_facility, request_to_institution: @maintenance_request.request_to_institution, request_to_org_structure: @maintenance_request.request_to_org_structure, requested_by: @maintenance_request.requested_by, requested_to: @maintenance_request.requested_to } }
    end

    assert_redirected_to maintenance_request_url(MaintenanceRequest.last)
  end

  test "should show maintenance_request" do
    get maintenance_request_url(@maintenance_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_request_url(@maintenance_request)
    assert_response :success
  end

  test "should update maintenance_request" do
    patch maintenance_request_url(@maintenance_request), params: { maintenance_request: { equipment_id: @maintenance_request.equipment_id, facility_id: @maintenance_request.facility_id, maintenance_description: @maintenance_request.maintenance_description, maintenance_type: @maintenance_request.maintenance_type, organization_structure_id: @maintenance_request.organization_structure_id, request_date: @maintenance_request.request_date, request_to_facility: @maintenance_request.request_to_facility, request_to_institution: @maintenance_request.request_to_institution, request_to_org_structure: @maintenance_request.request_to_org_structure, requested_by: @maintenance_request.requested_by, requested_to: @maintenance_request.requested_to } }
    assert_redirected_to maintenance_request_url(@maintenance_request)
  end

  test "should destroy maintenance_request" do
    assert_difference('MaintenanceRequest.count', -1) do
      delete maintenance_request_url(@maintenance_request)
    end

    assert_redirected_to maintenance_requests_url
  end
end
